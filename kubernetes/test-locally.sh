#!/bin/bash

# Script to test the Windsurf deployment locally using minikube
# This allows testing the Kubernetes setup before deploying to a production cluster

echo "=== Setting up local Kubernetes testing environment ==="

# Check if minikube is installed
if ! command -v minikube &> /dev/null; then
    echo "Error: minikube is not installed. Please install it first."
    echo "Visit: https://minikube.sigs.k8s.io/docs/start/"
    exit 1
fi

# Start minikube if not running
if ! minikube status | grep -q "Running"; then
    echo "Starting minikube..."
    minikube start --cpus=4 --memory=8g --driver=docker
fi

# Enable ingress addon
echo "Enabling ingress addon..."
minikube addons enable ingress

# Set docker env to use minikube's docker daemon
echo "Configuring docker to use minikube's daemon..."
eval $(minikube docker-env)

# Build the docker image directly in minikube
echo "Building Docker image in minikube..."
docker build -t windsurf-training:latest -f ../Dockerfile ..

# Create namespace
kubectl create namespace windsurf-training --dry-run=client -o yaml | kubectl apply -f -

# Create a test ConfigMap with a small sample dataset
echo "Creating test dataset..."
cat > test-dataset.csv << EOF
id,name,value,category
1,Item 1,10.5,A
2,Item 2,20.3,B
3,Item 3,15.7,A
4,Item 4,30.1,C
5,Item 5,25.9,B
EOF

# Create ConfigMap from the test dataset
kubectl create configmap dataset-config --from-file=dataset.csv=test-dataset.csv -n windsurf-training --dry-run=client -o yaml | kubectl apply -f -

# Deploy a scaled-down version (just 2 replicas for testing)
echo "Deploying test environment (2 replicas)..."
sed 's/replicas: 100/replicas: 2/g' deployment.yaml > test-deployment.yaml
kubectl apply -f test-deployment.yaml -n windsurf-training

# Apply service
kubectl apply -f service.yaml -n windsurf-training

# Apply ingress (with minikube domain)
sed 's/windsurf-training.example.com/windsurf.test/g' ingress.yaml > test-ingress.yaml
kubectl apply -f test-ingress.yaml -n windsurf-training

# Deploy web portal
echo "Deploying web portal..."
kubectl create configmap portal-content \
  --from-file=index.html=web-portal/index.html \
  --from-file=styles.css=web-portal/styles.css \
  --from-file=script.js=web-portal/script.js \
  -n windsurf-training --dry-run=client -o yaml | kubectl apply -f -

sed 's/portal.windsurf-training.example.com/portal.windsurf.test/g' web-portal-deployment.yaml > test-portal-deployment.yaml
kubectl apply -f test-portal-deployment.yaml -n windsurf-training

# Wait for deployments to be ready
echo "Waiting for deployments to be ready..."
kubectl rollout status deployment/windsurf-training -n windsurf-training
kubectl rollout status deployment/windsurf-portal -n windsurf-training

# Add hosts entries for testing
echo "\nTo test locally, add these entries to your /etc/hosts file:\n"
echo "$(minikube ip) windsurf.test portal.windsurf.test user-test.windsurf.test"

echo "\n=== Local test environment is ready! ==="
echo "Web portal: http://portal.windsurf.test"
echo "Direct access: http://windsurf.test"
echo "\nUse 'minikube dashboard' to monitor the Kubernetes resources"
echo "Use 'kubectl get pods -n windsurf-training' to see the running pods"
echo "\nTo clean up: kubectl delete namespace windsurf-training"
