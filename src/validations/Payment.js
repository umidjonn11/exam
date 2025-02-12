import { z } from "zod";
/*
  - **reservationId** (UUID) - Rezervatsiya identifikatori.
- **amount** (decimal) - To'lov summasi.
- **method** (string) - To'lov usuli (`credit_card`, `bank_transfer`, `paypal`).
- **status** (enum) - To'lov holati (`pending`, `completed`, `failed`).
- **transactionId** (string) - Tranzaksiya identifikatori.
- **createdAt** (timestamp) - Yaratilgan sana.
- **updatedAt** (timestamp) - Yangilangan sana.
*/
export const createPaymentSchema = z.object({
  amount: z.number(),
  status: z.enum([`pending`, `completed`, `failed`]).default("pending"),
  method: z.enum([`credit_card`, `bank_transfer`, `paypal`]),
});

export const updatePaymentSchema = z.object({
  amount: z.number().optional(),
  status: z.enum([`pending`, `completed`, `failed`]).optional(),
  method: z.string().optional(),
});
