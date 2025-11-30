# Use Python base image
FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy project files
COPY pyproject.toml ./
COPY client.py weather.py ./

# Install Python dependencies
RUN pip install --no-cache-dir anthropic mcp httpx sse-starlette fastapi uvicorn

# Set environment variable for ANTHROPIC_API_KEY
# This can be overridden at runtime
ENV ANTHROPIC_API_KEY=your_api_key_here

# Expose the port that the server will run on
EXPOSE 8080

# Default command to run the server
CMD ["python", "weather.py"]
