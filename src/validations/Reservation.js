import { z } from "zod";
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
export const createReservationSchema = z.object({
  reservationDate: z.string(),
  startTime: z.string(),
  endTime: z.string(),
  status: z.enum([`pending`, `confirmed`, `cancelled`]).default("pending"),
});

export const updateReservationSchema = z.object({
  reservationDate: z.string().optional(),
  startTime: z.string().optional(),
  endTime: z.string().optional(),
  status: z.enum([`pending`, `confirmed`, `cancelled`]).optional(),
});
