# Windsurf Training Environment

## Overview
This repository contains a Gitpod-based Windsurf environment for training approximately 100 users simultaneously. Each user will have access to a separate container with Windsurf IDE and a preloaded dataset for building dashboards without requiring local installations.

## For Administrators

### Deployment Instructions

1. **Fork this repository** to your GitHub account

2. **Create a Gitpod workspace** from your forked repository
   - Go to https://gitpod.io/
   - Connect your GitHub account
   - Create a new workspace from your forked repository

3. **Share the Gitpod workspace link** with users
   - Format: `https://gitpod.io/#https://github.com/YOUR_USERNAME/AIBIA-Docker`
   - You can also create a custom workspace link from the Gitpod dashboard

4. **Monitor resource usage**
   - Each user will have their own container
   - Gitpod provides monitoring tools in the workspace dashboard

### Scaling Considerations

- Each user requires approximately 2GB of RAM and 2 CPU cores
- For 100 users, ensure your Gitpod plan supports the required resources
- Consider using multiple repositories/workspaces if needed to distribute the load

## For Users

### Getting Started

1. **Click the workspace link** provided by your administrator

2. **Wait for the environment to initialize**
   - The Dockerfile will build automatically
   - Windsurf will start automatically

3. **Access the Windsurf IDE**
   - The IDE will open automatically in your browser
   - The dataset is preloaded at `/app/data/dataset.csv`

4. **Building Dashboards**
   - Use Streamlit, Dash, or Plotly for creating visualizations
   - Example: `streamlit run your_dashboard.py`

### Available Tools

- **Windsurf CLI**: For managing your development environment
- **Python Libraries**: pandas, plotly, dash, streamlit
- **Dataset**: Located at `/app/data/dataset.csv`

## Troubleshooting

- If the Windsurf IDE doesn't start automatically, run `windsurf start` in the terminal
- If you can't see the dataset, check `/workspace/app/data/` directory
- For port issues, ensure ports 8501 and 3000-3100 are accessible

## License

This project is for training purposes only.
