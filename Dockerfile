FROM ubuntu:latest

# Set noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install essential packages
RUN apt-get update && apt-get install -y \
    wget \
    git \
    build-essential \
    vim \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set Go version
ENV GO_VERSION=1.22.1

# Download and install Go
RUN wget -q https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
    && rm go${GO_VERSION}.linux-amd64.tar.gz

# Set Go environment variables
ENV GOPATH=/go
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Create workspace directories
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" "$GOPATH/pkg"

# Set working directory
WORKDIR /app

# Verify Go installation
RUN go version

# Keep container running
CMD ["tail", "-f", "/dev/null"]