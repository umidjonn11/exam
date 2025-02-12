import { Router } from "express";
import { locationController } from "../controllers/index.js"; 
import { authMiddleware } from "../middlewares/auth.middleware.js"; 
import { validateData } from "../middlewares/validation.middleware.js"; 
import { createLocationSchema,updateLocationSchema } from "../validations/index.js";
import { roleGuard } from "../middlewares/role.middleware.js";

export const locationRoutes = Router();

locationRoutes.post("/locations", authMiddleware, validateData(createLocationSchema), locationController.create);

locationRoutes.get("/locations", locationController.getAll);

locationRoutes.get("/locations/:id", locationController.getById);

locationRoutes.put("/locations/:id", authMiddleware,roleGuard("admin") ,validateData(updateLocationSchema), locationController.update);

locationRoutes.delete("/locations/:id", authMiddleware,roleGuard("admin","manager"), locationController.delete);

