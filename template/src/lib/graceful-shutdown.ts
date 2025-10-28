/**
 * Graceful shutdown utility
 * Handles SIGTERM and SIGINT signals for clean application shutdown
 */

type CleanupHandler = () => Promise<void> | void;

class GracefulShutdown {
  private cleanupHandlers: CleanupHandler[] = [];
  private isShuttingDown = false;

  /**
   * Register a cleanup handler to run during shutdown
   * @param handler - Async or sync function to run during cleanup
   */
  public register(handler: CleanupHandler): void {
    this.cleanupHandlers.push(handler);
  }

  /**
   * Initialize graceful shutdown listeners
   */
  public init(): void {
    // Handle SIGTERM (Docker/Kubernetes shutdown)
    process.on("SIGTERM", () => this.shutdown("SIGTERM"));

    // Handle SIGINT (Ctrl+C)
    process.on("SIGINT", () => this.shutdown("SIGINT"));
  }

  /**
   * Execute shutdown sequence
   */
  private async shutdown(signal: string): Promise<void> {
    if (this.isShuttingDown) {
      return;
    }

    this.isShuttingDown = true;

    // eslint-disable-next-line no-console
    console.log(`\nReceived ${signal}, starting graceful shutdown...`);

    try {
      // Run all cleanup handlers
      await Promise.all(
        this.cleanupHandlers.map(async (handler) => {
          try {
            await handler();
          } catch (error) {
            console.error("Error during cleanup:", error);
          }
        })
      );

      // eslint-disable-next-line no-console
      console.log("Graceful shutdown complete");
      process.exit(0);
    } catch (error) {
      console.error("Error during shutdown:", error);
      process.exit(1);
    }
  }
}

// Export singleton instance
export const gracefulShutdown = new GracefulShutdown();
