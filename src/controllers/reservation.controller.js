import { Reservation } from "../models/index.js";
import {
  createReservationSchema,
  updateReservationSchema,
} from "../validations/index.js";

export const reservationController = {
  async create(req, res, next) {
    try {
      
      const newReservation = new Reservation(req.body);
      await newReservation.save();

      res.status(201).json({
        reservationId: newReservation._id,
        message: "Reservation created",
      });
    } catch (error) {
      res.status(400).send(error.message);
    }
  },

  async getAll(req, res, next) {
    try {
      const reservations = await Reservation.find()
        .populate("customerId locationId")
        .exec();

      res.status(200).json(reservations);
    } catch (error) {
      res.status(400).send(error.message);
    }
  },

  async getById(req, res, next) {
    try {
      const { id } = req.params;

      const reservation = await Reservation.findById(id)
        .populate("customerId locationId")
        .exec();

      if (!reservation) {
        return res.status(404).json({ message: "Reservation not found" });
      }

      res.status(200).json(reservation);
    } catch (error) {
      res.status(400).send(error.message);
    }
  },

  async update(req, res, next) {
    try {
      const { id } = req.params;

      const validatedData = updateReservationSchema.parse(req.body);

      const updatedReservation = await Reservation.findByIdAndUpdate(
        id,
        validatedData,
        {
          new: true,
        }
      );

      if (!updatedReservation) {
        return res.status(404).json({ message: "Reservation not found" });
      }

      res.status(200).json({
        reservationId: updatedReservation._id,
        message: "Reservation updated",
      });
    } catch (error) {
      res.status(400).send(error.message);
    }
  },

  async delete(req, res, next) {
    try {
      const { id } = req.params;

      const deletedReservation = await Reservation.findByIdAndDelete(id);

      if (!deletedReservation) {
        return res.status(404).json({ message: "Reservation not found" });
      }

      res.status(200).json({
        message: "Reservation deleted",
      });
    } catch (error) {
      res.status(400).send(error.message);
        }
  },
};
