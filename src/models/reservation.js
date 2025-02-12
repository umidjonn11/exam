import { Schema, model } from "mongoose";

const ReservationSchema = new Schema(
  {
    /*
  - **customerId** (UUID) - Mijoz identifikatori.
- **locationId** (UUID) - Joy identifikatori.
- **reservationDate** (date) - Rezervatsiya sanasi.
- **startTime** (time) - Boshlanish vaqti.
- **endTime** (time) - Tugash vaqti.
- **status** (enum) - Rezervatsiya holati (`pending`, `confirmed`, `cancelled`).
- **createdAt** (timestamp) - Yaratilgan sana.
- **updatedAt** (timestamp) - Yangilangan sana.
*/
    customerId: {
      type: Schema.Types.ObjectId,
      ref: "Customer",
      required: true,
    },
    locationId: {
      type: Schema.Types.ObjectId,
      ref: "Location",
      required: true,
    },
    reservationDate: {
      type: String,
      required: true,
    },
    startTime: {
      type: String,
      required: true,
    },
    endTime: {
      type: String,
      required: true,
    },
    status: {
      type: String,
      enum: [`pending`, `confirmed`, `cancelled`],
    },
  },
  { timestamps: true }
);

export const Reservation = model("Reservation", ReservationSchema);
