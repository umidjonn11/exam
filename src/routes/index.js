import { Router } from "express";
import { authRouter } from "./customer.routes.js";
import { locationRoutes } from "./location.routes.js";
import { paymentRoutes } from "./payment.routes.js";
import { reservationRoutes } from "./reservation.routes.js";

export const apiRouter = Router();

apiRouter.use("/auth", authRouter);
apiRouter.use("/", locationRoutes);
apiRouter.use("/", reservationRoutes);
apiRouter.use("/", paymentRoutes);
