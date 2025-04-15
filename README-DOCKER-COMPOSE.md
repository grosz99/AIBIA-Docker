# Windsurf Training Environment with Docker Compose

## Overview

This is a simplified approach to deploy Windsurf training environments for 100 users without requiring GitHub accounts or complex Kubernetes setups. This solution uses Docker Compose with Traefik for routing.

## Prerequisites

1. **Docker and Docker Compose**
   - Install Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop/)
   - Docker Compose comes included with Docker Desktop

2. **Python 3.6+** (for the environment generator script)
   - Install from [python.org](https://www.python.org/downloads/)
   - Make sure to install PyYAML: `pip install pyyaml`

## Quick Start Guide

### Step 1: Generate the environments

```bash
# Generate configuration for 100 Windsurf environments
python generate-environments.py
```

### Step 2: Start the system

```bash
# Start all services
docker-compose up -d
```

### Step 3: Access the portal

Open your browser and go to:
- Portal: http://portal.localhost
- Traefik Dashboard: http://localhost:8080

## How It Works

1. **Traefik** acts as a reverse proxy, routing requests to the appropriate container
2. **Portal** provides a web interface for users to access their environments
3. **Windsurf Environments** are individual containers, one per user

## User Access Flow

1. Users visit the portal at http://portal.localhost
2. They enter their email, name, and select a session
3. The portal assigns them to a specific Windsurf environment
4. They access their environment directly via the provided link

## Customization

### Changing the number of environments

```bash
# Generate for a specific number of environments (e.g., 50)
python generate-environments.py 50
```

### Using a real domain

To use a real domain instead of .localhost:

1. Update the domain in `portal/script.js`
2. Regenerate the environments with the new domain
3. Configure your DNS to point to the server's IP address

## Scaling Considerations

- Each Windsurf environment requires approximately 2GB of RAM
- For 100 users, you'll need a server with at least 200GB RAM
- Consider using multiple servers if you don't have enough resources

## Troubleshooting

### Common Issues

1. **Port conflicts**
   - If ports 80 or 8080 are already in use, update the ports in docker-compose.yml

2. **Resource limitations**
   - If your computer doesn't have enough resources, reduce the number of environments

3. **Domain resolution**
   - Make sure your hosts file includes entries for portal.localhost and user-*.localhost

### Debugging Commands

```bash
# View all running containers
docker-compose ps

# View logs for a specific service
docker-compose logs portal

# View logs for a specific user environment
docker-compose logs windsurf-1
```

## Cleanup

```bash
# Stop all containers
docker-compose down

# Remove all containers and volumes
docker-compose down -v
```
