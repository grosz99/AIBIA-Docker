# Base image with Python and Node.js
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install OS-level dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    nodejs \
    npm \
    && apt-get clean

# Set npm and pip to ignore certificate errors
RUN npm config set strict-ssl false
ENV PYTHONHTTPSVERIFY=0
RUN pip config set global.trusted-host "pypi.org files.pythonhosted.org"

# Use our mock Windsurf implementation instead
COPY windsurf-mock.sh /usr/local/bin/windsurf
RUN chmod +x /usr/local/bin/windsurf

# Create a simple HTTP server for the training interface
RUN npm install -g http-server || echo "Warning: http-server installation failed, will use Python's HTTP server instead"

# Create a directory for the training interface
RUN mkdir -p /app/training

# Install dashboard libraries
RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --default-timeout=100 streamlit dash plotly pandas || echo "Warning: Some packages may not have installed properly" 

# Create data directory and add dataset
RUN mkdir -p /app/data
COPY data/dataset.csv /app/data/dataset.csv

# Expose ports
EXPOSE 3000
EXPOSE 8501

# Default command
CMD ["bash"]