# Deploying to Gitpod for 100 Users

This guide provides step-by-step instructions for deploying the Windsurf training environment to Gitpod and testing it with 100 simultaneous users.

## Deployment Steps

### 1. Push to GitHub

```bash
# Initialize git repository (if not already done)
git init

# Add all files
git add .

# Commit changes
git commit -m "Initial commit for Windsurf training environment"

# Add your GitHub repository as remote
git remote add origin https://github.com/grosz99/AIBIA-Docker.git

# Push to GitHub
git push -u origin main
```

### 2. Create Gitpod Workspace

1. Go to [Gitpod](https://gitpod.io/)
2. Connect your GitHub account if not already connected
3. Create a new workspace from your repository
4. Gitpod will automatically build the Docker image and start the environment

### 3. Verify One-Click Windsurf IDE Access

Once the Gitpod workspace is running:

1. Verify that the Windsurf IDE loads automatically in the browser
2. Confirm that users do not need to run any commands to start Windsurf
3. Test that the dataset is properly loaded at `/app/data/dataset.csv`

```bash
# If needed, you can manually launch Windsurf with:
windsurf launch --prefer-browser
```

## Scaling for 100 Users

### Option 1: Individual Workspaces

Each user creates their own Gitpod workspace from the same repository:

1. Share the repository URL with all users
2. Each user prefixes the URL with `https://gitpod.io/#` to create their own workspace
3. Example: `https://gitpod.io/#https://github.com/grosz99/AIBIA-Docker`

### Option 2: Gitpod Organization (Recommended)

Create a Gitpod organization to manage all workspaces:

1. Create a Gitpod organization account
2. Invite all 100 users to the organization
3. Configure workspace templates and resource limits
4. Monitor usage through the Gitpod dashboard

## Load Testing

Before the actual training session, perform load testing:

1. Create a test script that simulates multiple users:

```python
# save as load_test.py
import requests
import threading
import time

def simulate_user(user_id):
    print(f"User {user_id} starting session")
    try:
        # Simulate API calls to Windsurf
        response = requests.get("http://localhost:8501")
        print(f"User {user_id} received status code: {response.status_code}")
        # Simulate user activity for 30 seconds
        time.sleep(30)
    except Exception as e:
        print(f"User {user_id} encountered error: {str(e)}")

# Simulate 10 concurrent users (scale this up gradually)
threads = []
for i in range(10):
    t = threading.Thread(target=simulate_user, args=(i,))
    threads.append(t)
    t.start()
    # Stagger the start times slightly
    time.sleep(1)

# Wait for all threads to complete
for t in threads:
    t.join()

print("Load test complete")
```

2. Run the load test with increasing numbers of simulated users

## Monitoring During Training

1. Use Gitpod's dashboard to monitor workspace usage
2. Set up a simple status page for users to report issues
3. Have backup workspaces ready in case of failures

## Troubleshooting Common Issues

### Resource Limits

If users encounter resource limit issues:

1. Upgrade the Gitpod plan to allow more resources per workspace
2. Optimize the Docker image to use fewer resources
3. Split users across multiple repositories/workspaces

### Connection Issues

If users have connection problems:

1. Ensure all required ports are exposed in the Dockerfile and .gitpod.yml
2. Check that all ports have public visibility in .gitpod.yml
3. Verify network connectivity to Gitpod servers

### Dataset Access

If users can't access the dataset:

1. Verify the dataset is correctly copied to the expected location
2. Check file permissions in the container
3. Update the sample dashboard to check multiple possible dataset locations
