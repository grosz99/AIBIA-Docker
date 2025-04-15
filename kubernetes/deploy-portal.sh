#!/bin/bash

# Create ConfigMap for portal content
echo "Creating ConfigMap for web portal content..."

# Create the ConfigMap from the web portal files
kubectl create configmap portal-content \
  --from-file=index.html=web-portal/index.html \
  --from-file=styles.css=web-portal/styles.css \
  --from-file=script.js=web-portal/script.js \
  -n windsurf-training --dry-run=client -o yaml | kubectl apply -f -

# Apply the web portal deployment
echo "Deploying web portal..."
kubectl apply -f web-portal-deployment.yaml -n windsurf-training

echo "Web portal deployment completed!"
echo "Portal will be available at: portal.windsurf-training.example.com"
echo "(Replace with your actual domain configured in web-portal-deployment.yaml)"
