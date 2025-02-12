import { Schema, model } from "mongoose";

const PaymentSchema = new Schema(
  {
    /* - **reservationId** (UUID) - Rezervatsiya identifikatori.
- **amount** (decimal) - To'lov summasi.
- **method** (string) - To'lov usuli (`credit_card`, `bank_transfer`, `paypal`).
- **status** (enum) - To'lov holati (`pending`, `completed`, `failed`).
- **transactionId** (string) - Tranzaksiya identifikatori.
- **createdAt** (timestamp) - Yaratilgan sana.
- **updatedAt** (timestamp) - Yangilangan sana.
*/

    reservationId: {
      type: Schema.Types.ObjectId,
      ref: "Reservation",
      required: true,
    },
    amount: {
      type: Number,
      required: true,
    },

    method: {
      type: String,
      enum: [`credit_card`, `bank_transfer`, `paypal`],
    },
    status: {
      type: String,
      enum: [`pending`, `completed`, `failed`],
    },
  },
  { timestamps: true }
);

export const Payment = model("Payment", PaymentSchema);
