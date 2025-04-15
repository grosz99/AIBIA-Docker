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

# Create a mock Windsurf CLI since the real package might not exist
RUN mkdir -p /usr/local/lib/node_modules/@windsurf/cli
COPY mock-windsurf.sh /usr/local/bin/windsurf
RUN chmod +x /usr/local/bin/windsurf

# Install dashboard libraries
RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org streamlit dash plotly pandas

# Create data directory and add dataset
RUN mkdir -p /app/data
COPY data/dataset.csv /app/data/dataset.csv

# Expose default Streamlit port
EXPOSE 8501

# Default command
CMD ["bash"]
