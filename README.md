# Apache Tika Server with OCR Support

A Docker container that runs Apache Tika Server with full OCR capabilities via Tesseract. Extract text from virtually any document type, including scanned PDFs and images.

## Features

- **Apache Tika 3.1.0** - Latest version with all the newest parsers and extractors
- **Tesseract OCR** - Optical Character Recognition for scanned documents and images
- **REST API** - Simple HTTP interface for document processing
- **Multi-format Support** - Handles 1000+ file formats including PDF, Office docs, images, archives, and more
- **Zero Configuration** - Works out of the box with sensible defaults

## Quick Start

```bash
# Clone the repository
git clone <your-repo-url>
cd tika-ocr

# Build and start the container
docker-compose up -d

# Test it's working
curl http://localhost:9998/tika
```

## Usage Examples

### Extract text from a PDF
```bash
curl -T document.pdf http://localhost:9998/tika --header "Accept: text/plain"
```

### Extract text from a scanned image
```bash
curl -T scanned-document.jpg http://localhost:9998/tika --header "Accept: text/plain"
```

### Get metadata from a file
```bash
curl -T document.pdf http://localhost:9998/meta --header "Accept: application/json"
```

### Detect file type
```bash
curl -T mystery-file http://localhost:9998/detect/stream
```

## API Endpoints

- `PUT /tika` - Extract text content
- `PUT /meta` - Extract metadata
- `PUT /rmeta` - Extract recursive metadata and content
- `PUT /detect/stream` - Detect MIME type
- `GET /` - Server status and available endpoints

Full API documentation: https://wiki.apache.org/tika/TikaServer

## What Makes This Different?

Standard Apache Tika can extract embedded text from documents, but it **cannot** read text from images or scanned PDFs without OCR support. This container includes:

- **Tesseract OCR Engine**: Performs the actual optical character recognition
- **English Language Data**: Training data for accurate English text recognition  
- **Orientation Detection**: Automatically handles rotated or skewed scans

Without these additions, Tika would only extract:
- Embedded text from PDFs (not scanned pages)
- Metadata from images (not text within them)
- Text from office documents (not scanned documents)

## System Requirements

- Docker and Docker Compose
- At least 1GB RAM (2GB+ recommended for large documents)
- Port 9998 available

## Configuration

The container runs with default settings that work well for most use cases. If you need to customize:

### Change the port
Edit `docker-compose.yml`:
```yaml
ports:
  - "YOUR_PORT:9998"
```

### Add more OCR languages
Edit `Dockerfile` and add language packs:
```dockerfile
RUN apt-get install -y \
    tesseract-ocr-fra \  # French
    tesseract-ocr-deu \  # German
    tesseract-ocr-spa    # Spanish
```

### Adjust memory limits
For large documents, you may need to increase Java heap size. Edit `Dockerfile`:
```dockerfile
CMD ["java", "-Xmx2g", "-jar", "/tika-server.jar", "--host", "0.0.0.0"]
```

## Performance Notes

- **First request may be slow** - Tika loads parsers on demand
- **OCR is CPU intensive** - Processing scanned documents takes longer than native text extraction
- **Large files** - Consider increasing timeout values for files over 50MB

## Troubleshooting

### Container won't start
Check logs: `docker logs tika-ocr`

### OCR not working
Verify Tesseract is installed: 
```bash
docker exec tika-ocr tesseract --version
```

### Out of memory errors
Increase heap size in the Dockerfile (see Configuration section)

### Slow downloads during build
The Tika JAR is ~63MB. Build uses Maven Central for faster downloads.

## Tech Stack

- **Apache Tika 3.1.0** - Content extraction framework
- **Tesseract 4.x** - OCR engine
- **OpenJDK 17** - Java runtime
- **Debian Bullseye** - Base OS

## License

This project uses Apache Tika which is licensed under the Apache License 2.0.
Tesseract is licensed under the Apache License 2.0.

## Contributing

Issues and PRs welcome! Please test any changes with both regular documents and scanned images.

## Limitations

- OCR accuracy depends on image quality
- Handwriting recognition is limited
- Very large files (>100MB) may require configuration adjustments
- Currently only includes English language OCR data

## Security Considerations

This service accepts and processes arbitrary files. In production:
- Run behind a reverse proxy
- Implement rate limiting
- Sanitize file uploads
- Monitor resource usage
- Consider running with limited user privileges

---

Built with frustration, debugged with determination, and deployed with hope that it actually works. 🚀