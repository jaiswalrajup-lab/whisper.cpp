FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    curl \
    bash

# Working directory
WORKDIR /app

# Copy project
COPY . .

# Build whisper.cpp
RUN cmake -B build && cmake --build build -j

# Make script executable
RUN chmod +x start.sh

# Expose port (Render will override with $PORT internally if needed)
EXPOSE 10000

# Start using script
CMD ["bash", "start.sh"]
