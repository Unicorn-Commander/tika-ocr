FROM openjdk:17-slim

# Install Tesseract and OCR language support
RUN apt-get update && \
    apt-get install -y \
        tesseract-ocr \
        tesseract-ocr-eng \
        tesseract-ocr-osd \
        curl && \
    apt-get clean

# Set Tesseract data path
ENV TESSDATA_PREFIX=/usr/share/tesseract-ocr/4.00/tessdata

# Download Tika 3.x server (requires Java 11+)
ENV TIKA_VERSION=3.1.0
RUN curl -fsSL -o /tika-server.jar \
    https://repo1.maven.org/maven2/org/apache/tika/tika-server-standard/${TIKA_VERSION}/tika-server-standard-${TIKA_VERSION}.jar && \
    echo "Downloaded Tika JAR:" && ls -lh /tika-server.jar

EXPOSE 9998

# Start Tika server
CMD ["java", "-jar", "/tika-server.jar", "--host", "0.0.0.0"]