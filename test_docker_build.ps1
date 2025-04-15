# PowerShell script to test Docker build and run

Write-Host "=== Testing Windsurf Docker Build ==="
Write-Host "Building Docker image..."

# Build the Docker image
docker build -t windsurf-training .

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Docker build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "Docker image built successfully!" -ForegroundColor Green
Write-Host ""

Write-Host "=== Testing Docker Container ==="
Write-Host "Starting container..."

# Run the container with port mapping
docker run -d --name windsurf-test -p 8501:8501 -p 3000:3000 windsurf-training

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to start Docker container!" -ForegroundColor Red
    exit 1
}

Write-Host "Container started successfully!" -ForegroundColor Green
Write-Host ""

# Wait a moment for the container to initialize
Start-Sleep -Seconds 2

Write-Host "=== Container Information ==="
docker ps -a | Select-String "windsurf-test"
Write-Host ""

Write-Host "=== Testing Environment Inside Container ==="
docker exec windsurf-test ls -la /app/data

Write-Host ""
Write-Host "=== Cleanup ==="
Write-Host "Stopping and removing test container..."

# Stop and remove the container
docker stop windsurf-test
docker rm windsurf-test

Write-Host "Test complete!" -ForegroundColor Green
Write-Host ""
Write-Host "To deploy to Gitpod, push this repository to GitHub and create a Gitpod workspace from it."
Write-Host "Refer to README.md for detailed instructions."
