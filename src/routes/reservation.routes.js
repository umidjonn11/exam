import { Router } from "express";
import { reservationController } from "../controllers/index.js";
import { authMiddleware } from "../middlewares/auth.middleware.js";
import { validateData } from "../middlewares/validation.middleware.js";
import { createReservationSchema, updateReservationSchema } from "../validations/index.js";
import { roleGuard } from "../middlewares/role.middleware.js";

export const reservationRoutes = Router();

reservationRoutes.post("/reservations", authMiddleware,  validateData(createReservationSchema), reservationController.create);

reservationRoutes.get("/reservations",  reservationController.getAll);

reservationRoutes.get("/reservations/:id",  reservationController.getById);

reservationRoutes.put("/reservations/:id", authMiddleware, roleGuard("admin"), validateData(updateReservationSchema), reservationController.update);

reservationRoutes.delete( "/reservations/:id",  authMiddleware,  roleGuard("admin", "manager"),  reservationController.delete);

