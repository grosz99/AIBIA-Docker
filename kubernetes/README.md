# Windsurf Training Kubernetes Deployment

## Overview

This directory contains all the necessary configurations and scripts to deploy the Windsurf training environment for 100 simultaneous users using Kubernetes. This approach doesn't require users to have GitHub accounts and provides a scalable, centrally managed solution.

## Architecture

- **Kubernetes Cluster**: Hosts all components of the training environment
- **Windsurf Pods**: 100 isolated environments, one per user
- **Web Portal**: Simple interface for users to access their assigned environment
- **Shared Dataset**: Pre-loaded in each pod at `/app/data/dataset.csv`

## Prerequisites

1. A Kubernetes cluster with sufficient resources:
   - At least 100 CPU cores (1 core per user)
   - At least 200GB RAM (2GB per user)
   - Kubernetes v1.19+ with Ingress controller installed

2. `kubectl` configured to access your cluster

3. A container registry to store your Docker image

4. A domain name with wildcard DNS configured (e.g., `*.windsurf-training.example.com`)

## Deployment Steps

### 1. Build and Push the Docker Image

```bash
# Update the registry in build_and_push.sh
vim build_and_push.sh

# Make the script executable
chmod +x build_and_push.sh

# Run the script
./build_and_push.sh
```

### 2. Update Configuration Files

Edit the following files to match your environment:

1. **deployment.yaml**: Update image name if you changed it
2. **ingress.yaml**: Update the host domain
3. **web-portal-deployment.yaml**: Update the host domain

### 3. Deploy the Windsurf Environment

```bash
# Make the deploy script executable
chmod +x deploy.sh

# Run the deployment
./deploy.sh
```

### 4. Deploy the Web Portal

```bash
# Make the portal deploy script executable
chmod +x deploy-portal.sh

# Deploy the web portal
./deploy-portal.sh
```

## Access and Usage

1. **Administrator Access**:
   - Monitor the deployment: `kubectl get pods -n windsurf-training`
   - View logs: `kubectl logs -n windsurf-training deployment/windsurf-training`
   - Scale if needed: `kubectl scale -n windsurf-training deployment/windsurf-training --replicas=120`

2. **User Access**:
   - Users visit the portal URL: `https://portal.windsurf-training.example.com`
   - They enter their email, name, and select a session
   - The portal assigns them to a specific Windsurf environment
   - They can then access their environment directly via the provided link

## Scaling Considerations

- The default configuration is set for 100 users
- To support more users, increase the `replicas` count in `deployment.yaml`
- Consider using node affinity or pod anti-affinity for better distribution
- For very large deployments (500+ users), consider multiple Kubernetes clusters

## Troubleshooting

### Common Issues

1. **Insufficient Resources**:
   - Error: `0/3 nodes are available: 3 Insufficient memory`
   - Solution: Add more nodes to your cluster or reduce resource requests

2. **Image Pull Errors**:
   - Error: `ImagePullBackOff` or `ErrImagePull`
   - Solution: Verify registry credentials and image path

3. **Ingress Issues**:
   - Error: Users cannot access their environments
   - Solution: Check Ingress controller logs and DNS configuration

### Debugging Commands

```bash
# Check pod status
kubectl get pods -n windsurf-training

# View pod details
kubectl describe pod [pod-name] -n windsurf-training

# Check logs
kubectl logs [pod-name] -n windsurf-training

# Check ingress
kubectl get ingress -n windsurf-training
kubectl describe ingress windsurf-ingress -n windsurf-training
```

## Cleanup

To remove the entire deployment:

```bash
kubectl delete namespace windsurf-training
```

## Security Considerations

- The portal does not implement authentication - add this for production use
- Consider adding network policies to isolate pods from each other
- Implement proper TLS for all ingress resources in production
