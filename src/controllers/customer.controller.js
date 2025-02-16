import jwt from "jsonwebtoken";
import { Customer, Otp } from "../models/index.js";
import otpGenerator from "otp-generator";
import { sendMail } from "../common/mail.js";

export const authController = {
  async register(req, res, next) {
    try {
      const body = req.body;
      const customer = new Customer(body);

      if (body.password !== body.confirmPassword) {
        return res.status(400).json("Invalid confirmPassword");
      }

      await customer.save();

      const otp = otpGenerator.generate(6, {
        upperCaseAlphabets: false,
        digits: true,
        specialChars: false,
      });

      sendMail(body.email, `this is yout OTP:${otp}`);
      const currentOtp = new Otp({ code: otp, author_id: customer._id });
      await currentOtp.save();

      res.status(201).json({
        message: "registred",
        data: customer,
      });
    } catch (error) {
      if (error.code === 11000) {
        error.message = "Customer already exists";
        error.code = 400;
        res.status(400).json(error);
        return;
      }
      next(error);
    }
  },
  async login(req, res, next) {
    try {
      const body = req.body;

      if (!body.email || !body.password) {
        throw new Error("Email and password are required");
      }

      const customer = await Customer.findOne({
        email: body.email,
      });

      if (!customer) {
        throw new Error("Customer not found");
      }

      console.log({
        userPassword: body.password,
        dbUserPassword: customer.password,
      });

      if (body.password !== customer.password) {
        res.status(400).json("Invalid credentials");
      }

      const payload = {
        sub: customer.id,
        role: customer.role,
        name: customer.name,
      };

      const accessToken = await jwt.sign(
        payload,
        process.env.JWT_ACCESS_SECRET,
        {
          expiresIn: process.env.JWT_ACCESS_EXPIRES_IN,
        }
      );

      const refreshToken = await jwt.sign(
        payload,
        process.env.JWT_REFRESH_SECRET,
        {
          expiresIn: process.env.JWT_REFRESH_EXPIRES_IN,
        }
      );

      res.send({
        data: {
          accessToken,
          refreshToken,
        },
      });
    } catch (error) {
      next(error);
    }
  },
  async profile(req, res, next) {
    try {
      const customer = req.customer;

      res.send({
        messagge: "profile",
        data: customer,
      });
    } catch (error) {
      res.status(500).send("Server error");
    }
  },
  async logout(req, res, next) {
    try {
      const token = req.headers.authorization?.split(" ")[1];

      if (!token) {
        return res.status(400).json({ message: "Token is required" });
      }

      let decodedToken;
      try {
        decodedToken = jwt.verify(token, process.env.JWT_ACCESS_SECRET);
      } catch (error) {
        return res.status(401).json({ message: "Token is invalid or expired" });
      }

      const customer = await Customer.findById(decodedToken.sub);

      if (!customer) {
        return res.status(404).json({ message: "Customer not found" });
      }

      res.status(200).json({ message: "Logout successful" });
    } catch (error) {
      next(error);
    }
  },

  generateOtp() {
    return otpGenerator.generate(6, {
      upperCaseAlphabets: false,
      specialChars: false,
    });
  },
  async verify(req, res, next) {
    try {
      const body = req.body;

      const customer = await Customer.findOne({
        username: body.username,
      });

      if (!customer) {
        throw new Error("Customer not found");
      }

      const otp = await Otp.findOne({
        code: body.code,
      });

      if (!otp) {
        throw new Error("otp is not valid");
      }

      await Customer.findByIdAndUpdate(customer._id, {
        $set: { isActive: "active" },
      });
      await Otp.findByIdAndDelete(otp._id);
      res.send("OTP verified account activated");
    } catch (error) {
      next(error);
    }
  },
  async delete(req, res, next) {
    try {
      const { id } = req.params;

      const deletedCustomer = await Customer.findByIdAndDelete(id);

      if (!deletedCustomer) {
        return res.status(404).json({ message: "Customer is  not found" });
      }

      res.status(200).json({
        message: "Customer is deleted",
      });
    } catch (error) {
      res.status(400).send(error.message);
    }
  },
};