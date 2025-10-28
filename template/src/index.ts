import { env } from "@/lib/env";
import { gracefulShutdown } from "@/lib/graceful-shutdown";

/**
 * Main entry point for the application
 */
function main(): void {
  try {
    // Environment variables are validated at import time
    // eslint-disable-next-line no-console
    console.log(`Application started in ${env.NODE_ENV} mode`);

    // Initialize graceful shutdown
    gracefulShutdown.init();

    // Register cleanup handlers
    gracefulShutdown.register(async () => {
      // eslint-disable-next-line no-console
      console.log("Cleaning up resources...");
      // Close database connections, stop servers, etc.
    });

    // Your application logic goes here
  } catch (error) {
    console.error("Failed to start application:", error);
    process.exit(1);
  }
}

// Handle unhandled promise rejections
process.on("unhandledRejection", (reason, promise) => {
  console.error("Unhandled Rejection at:", promise, "reason:", reason);
  process.exit(1);
});

// Handle uncaught exceptions
process.on("uncaughtException", (error) => {
  console.error("Uncaught Exception:", error);
  process.exit(1);
});

// Run the application
main();

export {};
