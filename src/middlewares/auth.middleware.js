import jwt from "jsonwebtoken";
import { Customer } from "../models/index.js";
import { custom } from "zod";
export const authMiddleware = async (req, res, next) => {
	try {
		if (!req.headers.authorization) {
			res.status(403).send("wrong authorization type");
			return;
		}

		const [type, token] = req.headers.authorization.split(" ");
		

		if (type !== "Bearer") {
			res.status(403).send("wrong authorization type");
			return;
		}

		const decode = await jwt.verify(token, process.env.JWT_ACCESS_SECRET);

		const customer = await Customer.findById(decode.sub);

		if (!customer) {
			throw new Error("Customer not found");
		}

		req.customer = customer;

		next();
	} catch (error) {
		res.send(error);
	}
};