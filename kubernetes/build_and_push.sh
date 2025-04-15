#!/bin/bash

# Set variables
REGISTRY="your-registry.example.com"  # Replace with your container registry
IMAGE_NAME="windsurf-training"
TAG="latest"

# Build the Docker image
echo "Building Docker image..."
docker build -t ${REGISTRY}/${IMAGE_NAME}:${TAG} -f ../Dockerfile ..

# Push the image to the registry
echo "Pushing image to registry..."
docker push ${REGISTRY}/${IMAGE_NAME}:${TAG}

echo "Image built and pushed successfully!"
