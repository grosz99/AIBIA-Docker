#!/usr/bin/env python3

"""
Script to generate Docker Compose configuration for multiple Windsurf environments.
This creates a docker-compose.override.yml file with 100 Windsurf containers.
"""

import os
import sys
import yaml

def generate_environments(num_environments=100):
    """Generate docker-compose.override.yml with the specified number of environments."""
    
    services = {}
    
    # Create service definitions for each environment
    for i in range(1, num_environments + 1):
        service_name = f"windsurf-{i}"
        host_name = f"user-{i}.localhost"
        
        services[service_name] = {
            "build": {
                "context": ".",
                "dockerfile": "Dockerfile"
            },
            "labels": [
                "traefik.enable=true",
                f"traefik.http.routers.{service_name}.rule=Host(`{host_name}`)",
                f"traefik.http.routers.{service_name}.entrypoints=web",
                f"traefik.http.services.{service_name}.loadbalancer.server.port=8501"
            ],
            "volumes": [
                "./data:/app/data"
            ],
            "networks": [
                "windsurf-network"
            ]
        }
    
    # Create the override file structure
    compose_override = {
        "version": "3.8",
        "services": services
    }
    
    # Write to docker-compose.override.yml
    with open("docker-compose.override.yml", "w") as f:
        yaml.dump(compose_override, f, default_flow_style=False)
    
    print(f"Generated docker-compose.override.yml with {num_environments} Windsurf environments")
    print("User environments will be accessible at:")
    for i in range(1, min(6, num_environments + 1)):
        print(f"  - http://user-{i}.localhost")
    if num_environments > 5:
        print(f"  - ... and {num_environments - 5} more")

def main():
    # Get number of environments from command line argument or use default
    num_environments = 100
    if len(sys.argv) > 1:
        try:
            num_environments = int(sys.argv[1])
            if num_environments <= 0:
                raise ValueError("Number of environments must be positive")
        except ValueError as e:
            print(f"Error: {e}")
            print("Usage: python generate-environments.py [number_of_environments]")
            sys.exit(1)
    
    generate_environments(num_environments)

if __name__ == "__main__":
    main()
