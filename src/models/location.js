import { Schema, model } from "mongoose";

const LocationSchema = new Schema(
  {
    /*- **id** (UUID) - Joy identifikatori.
- **name** (string) - Joy nomi.
- **description** (text) - Joy ta'rifi.
- **capacity** (integer) - Maksimal sig'im.
- **address** (string) - Manzil.
- **status** (enum) - Holati (`available`, `unavailable`).
- **createdAt** (timestamp) - Yaratilgan sana.
- **updatedAt** (timestamp) - Yangilangan sana.
*/
    name: {
      type: String,
      required: true,
      trim: true,
    },
    description: {
      type: String,
      required: true,
    },
    capacity: {
      type: Number,
      required: true,
    },
    address: {
      type: String,
      required: true,
    },
    status: {
      type: String,
      enum: ["available", "unavailable"],
    },
  },
  { timestamps: true }
);

export const Location = model("Location", LocationSchema);