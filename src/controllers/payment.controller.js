import { Payment } from "../models/index.js";
import { updatePaymentSchema } from "../validations/index.js";

export const paymentController = {
  async create(req, res, next) {
    try {
      const newPayment = new Payment(req.body);
      await newPayment.save();

      res.status(201).json({
        paymentId: newPayment._id,
        message: "Payment created",
      });
    } catch (error) {
        res.status(400).send(error.message);
    }
  },

  async getAll(req, res, next) {
    try {
      const payments = await Payment.find().populate("reservationId").exec();

      res.status(200).json(payments);
    } catch (error) {
        res.status(400).send(error.message);
    }
  },

  async getById(req, res, next) {
    try {
      const { id } = req.params;

      const payment = await Payment.findById(id)

      if (!payment) {
        return res.status(404).json({ message: "Payment not found" });
      }

      res.status(200).json(payment);
    } catch (error) {
        res.status(400).send(error.message);
    }
  },

  async update(req, res, next) {
    try {
      const { id } = req.params;

      const validatedData = updatePaymentSchema.parse(req.body);

      const updatedPayment = await Payment.findByIdAndUpdate(
        id,
        validatedData,
        {
          new: true,
        }
      );

      if (!updatedPayment) {
        return res.status(404).json({ message: "Payment not found" });
      }

      res.status(200).json({
        paymentId: updatedPayment._id,
        message: "Payment updated",
      });
    } catch (error) {
        res.status(400).send(error.message);
    }
  },

  async delete(req, res, next) {
    try {
      const { id } = req.params;

      const deletedPayment = await Payment.findByIdAndDelete(id);

      if (!deletedPayment) {
        return res.status(404).json({ message: "Payment not found" });
      }

      res.status(200).json({
        message: "Payment deleted",
      });
    } catch (error) {
        res.status(400).send(error.message);
    }
  },
};
