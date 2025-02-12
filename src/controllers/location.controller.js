import { Location } from "../models/index.js";
import {
  createLocationSchema,
  updateLocationSchema,
} from "../validations/index.js";

export const locationController = {
  async create(req, res, next) {
    try {
      const validatedData = createLocationSchema.parse(req.body);

      const newLocation = new Location(validatedData);
      await newLocation.save();

      res.status(201).json({
        locationId: newLocation._id,
        message: "Location created",
      });
    } catch (error) {
      res.status(400).send(error.message);
    }
  },

  async getAll(req, res, next) {
    try {
      const locations = await Location.find();
      res.status(200).json(locations);
    } catch (error) {
      res.status(400).send(error.message);
    }
  },

  async getById(req, res, next) {
    try {
      const { id } = req.params;
      const location = await Location.findById(id);

      if (!location) {
        return res.status(404).json({ message: "Location not found" });
      }

      res.status(200).json(location);
    } catch (error) {
      res.status(400).send(error.message);
    }
  },

  async update(req, res, next) {
    try {
      const { id } = req.params;

      const validatedData = updateLocationSchema.parse(req.body);

      const updatedLocation = await Location.findByIdAndUpdate(
        id,
        validatedData,
        {
          new: true,
        }
      );

      if (!updatedLocation) {
        return res.status(404).json({ message: "Location not found" });
      }

      res.status(200).json({
        locationId: updatedLocation._id,
        message: "Location updated",
      });
    } catch (error) {
      res.status(400).send(error.message);
    }
  },

  async delete(req, res, next) {
    try {
      const { id } = req.params;

      const deletedLocation = await Location.findByIdAndDelete(id);

      if (!deletedLocation) {
        return res.status(404).json({ message: "Location is not found" });
      }

      res.status(200).json({
        message: "Location is deleted",
      });
    } catch (error) {
      res.status(400).send(error.message);
    }
  },
};


/* async create(req,res,next){
const validateData=createLocationSchema.parse(req.body)
const location=new Location(validatedata)

}









*/