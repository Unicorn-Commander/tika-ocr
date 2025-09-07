
# Tika OCR Standalone

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/Unicorn-Commander/tika-ocr)
[![Docker Pulls](https://img.shields.io/docker/pulls/unicorncommander/tika-ocr.svg)](https://hub.docker.com/r/unicorncommander/tika-ocr)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This project provides a standalone, containerized Tika OCR service using Docker. It's designed to be easy to use, configure, and extend.

## Features

*   **OCR:** Extracts text from images and PDFs.
*   **Standalone:** Runs in a Docker container, independent of other services.
*   **Configurable:** Easily extend and customize the service.
*   **Based on Official Images:** Uses the official `openjdk` and `tesseract` images for a stable and secure base.

## Getting Started

### Prerequisites

*   [Docker](https://docs.docker.com/get-docker/)
*   [Docker Compose](https://docs.docker.com/compose/install/)

### Installation and Usage

1.  **Clone the repository:**

    ```sh
    git clone https://github.com/Unicorn-Commander/tika-ocr.git
    cd tika-ocr
    ```

2.  **Build and run the service:**

    ```sh
    docker-compose up -d --build
    ```

3.  **The Tika service will be available at:**

    ```
    http://localhost:9998
    ```

### Configuration

You can configure the Tika service by modifying the `docker-compose.yml` file. For example, you can change the port mappings or add environment variables.

### Customization

You can customize the Dockerfile to add more languages or other features. For example, to add support for Spanish, you would add the `tesseract-ocr-spa` package to the `apt-get install` command in the `Dockerfile`.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
