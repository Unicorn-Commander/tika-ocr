
# Standalone Tika OCR Service

This project provides a standalone Tika OCR service in a Docker container.

## Usage

1.  **Build and run the container:**
    ```sh
    docker-compose up -d --build
    ```

2.  **The Tika service will be available at:**
    ```
    http://localhost:9998
    ```

3.  **To stop the service:**
    ```sh
    docker-compose down
    ```
