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

# Install the official Windsurf IDE with proper error handling
RUN npm config set registry https://registry.npmjs.org/ && \
    npm config set strict-ssl false && \
    npm install -g @windsurf/cli --force && \
    npm cache clean --force

# Verify Windsurf CLI installation and provide clear status
RUN windsurf --version && echo "Windsurf IDE successfully installed!" || \
    echo "Retrying Windsurf IDE installation..." && \
    npm install -g @windsurf/cli --force

# Ensure Windsurf CLI is properly set up
RUN which windsurf && chmod +x $(which windsurf) || echo "Windsurf CLI not found at expected location"

# Create Windsurf configuration to ensure immediate startup
RUN mkdir -p /root/.config/windsurf/ && \
    echo '{"autoLaunch": true, "preferBrowser": true}' > /root/.config/windsurf/config.json

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