import { z } from "zod";
/*- **id** (UUID) - Joy identifikatori.
- **name** (string) - Joy nomi.
- **description** (text) - Joy ta'rifi.
- **capacity** (integer) - Maksimal sig'im.
- **address** (string) - Manzil.
- **status** (enum) - Holati (`available`, `unavailable`).
- **createdAt** (timestamp) - Yaratilgan sana.
- **updatedAt** (timestamp) - Yangilangan sana.
*/
export const createLocationSchema = z.object({
  name: z.string(),
  description: z.string(),
  capacity: z.number(),
  status: z.enum(["available", "unavailable"]),
  address: z.string(),
});

export const updateLocationSchema = z.object({
  name: z.string().optional(),
  description: z.string().optional(),
  capacity: z.number().optional(),
  status: z.enum(["available", "unavailable"]).optional(),
  address: z.string().optional(),
});