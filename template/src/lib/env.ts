import { z } from "zod";

/**
 * Environment variable schema
 * Add your required environment variables here
 */
const envSchema = z.object({
  NODE_ENV: z
    .enum(["development", "production", "test"])
    .default("development"),
  // Add your environment variables here
  // Example:
  // PORT: z.coerce.number().default(3000),
  // DATABASE_URL: z.string().url(),
  // API_KEY: z.string().min(1),
});

/**
 * Validated environment variables
 * This will throw an error if validation fails
 */
export const env = envSchema.parse(process.env);

/**
 * Type-safe environment variables
 */
export type Env = z.infer<typeof envSchema>;
