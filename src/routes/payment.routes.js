import { Router } from "express";
import { paymentController } from "../controllers/index.js";
import { authMiddleware } from "../middlewares/auth.middleware.js";
import { validateData } from "../middlewares/validation.middleware.js";
import { createPaymentSchema, updatePaymentSchema } from "../validations/index.js";
import { roleGuard } from "../middlewares/role.middleware.js";

export const paymentRoutes = Router();

paymentRoutes.post("/payments", authMiddleware,  validateData(createPaymentSchema), paymentController.create);

paymentRoutes.get("/payments", authMiddleware,roleGuard("admin","manager"), paymentController.getAll);

paymentRoutes.get("/payments/:id",  paymentController.getById);

paymentRoutes.put("/payments/:id", authMiddleware, roleGuard("admin"), validateData(updatePaymentSchema), paymentController.update);

paymentRoutes.delete( "/payments/:id",  authMiddleware,  roleGuard("admin", "manager"),  paymentController.delete);
