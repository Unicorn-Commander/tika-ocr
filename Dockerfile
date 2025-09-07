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

# Download latest Tika server
ENV TIKA_VERSION=3.1.0
RUN curl -L -o /tika-server.jar https://downloads.apache.org/tika/${TIKA_VERSION}/tika-server-standard-${TIKA_VERSION}.jar

EXPOSE 9998

# ✅ Just start without any extra flags for Tika 3.x
CMD ["java", "-jar", "/tika-server.jar", "--host", "0.0.0.0"]