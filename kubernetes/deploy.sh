#!/bin/bash

# Apply Kubernetes configurations
echo "Deploying Windsurf training environment to Kubernetes..."

# Create namespace if it doesn't exist
kubectl create namespace windsurf-training --dry-run=client -o yaml | kubectl apply -f -

# Apply ConfigMap first (for dataset)
kubectl apply -f configmap.yaml -n windsurf-training

# Apply Deployment
kubectl apply -f deployment.yaml -n windsurf-training

# Apply Service
kubectl apply -f service.yaml -n windsurf-training

# Apply Ingress
kubectl apply -f ingress.yaml -n windsurf-training

echo "Deployment completed!"
echo "Waiting for pods to be ready..."

# Wait for deployment to be ready
kubectl rollout status deployment/windsurf-training -n windsurf-training

echo "Windsurf training environment is now available at: windsurf-training.example.com"
echo "(Replace with your actual domain configured in ingress.yaml)"
