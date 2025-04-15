# PowerShell script to test the Docker Compose setup locally

Write-Host "=== Testing Windsurf Training Environment ==="
Write-Host "This script will help you test the Docker Compose setup locally."

# Check if Docker is installed
try {
    $dockerVersion = docker --version
    Write-Host "Docker is installed: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Docker is not installed or not in PATH!" -ForegroundColor Red
    Write-Host "Please install Docker Desktop from https://www.docker.com/products/docker-desktop/" -ForegroundColor Red
    exit 1
}

# Check if Python is installed
try {
    $pythonVersion = python --version
    Write-Host "Python is installed: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "Warning: Python is not installed or not in PATH." -ForegroundColor Yellow
    Write-Host "You will need Python to generate multiple environments." -ForegroundColor Yellow
    Write-Host "Install Python from https://www.python.org/downloads/" -ForegroundColor Yellow
}

# Check if PyYAML is installed
if (python -c "import yaml" 2>$null) {
    Write-Host "PyYAML is installed." -ForegroundColor Green
} else {
    Write-Host "Warning: PyYAML is not installed." -ForegroundColor Yellow
    Write-Host "Installing PyYAML..."
    pip install pyyaml
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error: Failed to install PyYAML. Please install it manually with 'pip install pyyaml'" -ForegroundColor Red
    } else {
        Write-Host "PyYAML installed successfully." -ForegroundColor Green
    }
}

# Generate a small number of environments for testing
Write-Host "\nGenerating test environments (5 environments)..."
python generate-environments.py 5

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to generate environments." -ForegroundColor Red
    exit 1
}

# Start Docker Compose
Write-Host "\nStarting Docker Compose services..."
docker-compose up -d

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to start Docker Compose services." -ForegroundColor Red
    exit 1
}

Write-Host "\nServices started successfully!" -ForegroundColor Green

# Add hosts entries to hosts file
Write-Host "\nTo test locally, you need to add entries to your hosts file."
Write-Host "The following entries should be added to C:\Windows\System32\drivers\etc\hosts:"
Write-Host "127.0.0.1 portal.localhost" -ForegroundColor Cyan
Write-Host "127.0.0.1 user-1.localhost" -ForegroundColor Cyan
Write-Host "127.0.0.1 user-2.localhost" -ForegroundColor Cyan
Write-Host "127.0.0.1 user-3.localhost" -ForegroundColor Cyan
Write-Host "127.0.0.1 user-4.localhost" -ForegroundColor Cyan
Write-Host "127.0.0.1 user-5.localhost" -ForegroundColor Cyan

Write-Host "\nWould you like to automatically add these entries to your hosts file? (requires admin privileges)" -ForegroundColor Yellow
Write-Host "Press Y to continue or any other key to skip: " -NoNewline

$key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
if ($key.Character -eq 'Y' -or $key.Character -eq 'y') {
    # Add entries to hosts file (requires admin privileges)
    $hostsFile = "C:\Windows\System32\drivers\etc\hosts"
    $hostEntries = @(
        "127.0.0.1 portal.localhost",
        "127.0.0.1 user-1.localhost",
        "127.0.0.1 user-2.localhost",
        "127.0.0.1 user-3.localhost",
        "127.0.0.1 user-4.localhost",
        "127.0.0.1 user-5.localhost"
    )
    
    try {
        $hostEntries | Out-File -Append -FilePath $hostsFile -Encoding ascii
        Write-Host "\nEntries added to hosts file successfully!" -ForegroundColor Green
    } catch {
        Write-Host "\nError: Failed to add entries to hosts file. You may need to run this script as Administrator." -ForegroundColor Red
        Write-Host "Please add the entries manually." -ForegroundColor Yellow
    }
} else {
    Write-Host "\nSkipped adding entries to hosts file. Please add them manually." -ForegroundColor Yellow
}

# Display access information
Write-Host "\n=== Access Information ==="
Write-Host "Portal: http://portal.localhost" -ForegroundColor Green
Write-Host "Traefik Dashboard: http://localhost:8080" -ForegroundColor Green
Write-Host "Test Environment: http://user-1.localhost" -ForegroundColor Green

Write-Host "\nTo stop the services, run: docker-compose down"
Write-Host "For a full cleanup, run: docker-compose down -v"

Write-Host "\nTest complete! The Docker Compose setup is now running locally."
