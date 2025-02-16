import { Schema, model } from "mongoose";

const customerSchema = new Schema(
  {
    email: {
      type: String,
      required: true,
      unique: true,
      trim: true,
      lowercase: true,
    },
    username: {
      type: String,
      required: true,
      trim: true,
      unique: true,
    },
    password: {
      type: String,
      required: true,
    },
    confirmPassword: {
      type: String,
      required: true,
    },
    role: {
      type: String,
      enum: ["user", "admin", "manager"],
    },
    firstName: {
      type: String,
      required: true,
    },
    lastName: {
      type: String,
      required: true,
    },
    isActive:{
      type:String,
      default:"inactive"
    }
  },
  { timestamps: true }
);

export const Customer = model("Customer", customerSchema);