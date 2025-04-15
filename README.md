# Windsurf Training Environment

## Overview
This repository contains a one-click Windsurf IDE training environment for approximately 100 users simultaneously. Each user gets their own isolated environment with the real Windsurf IDE pre-loaded and launched automatically. No setup, configuration, or GitHub account required - users simply click a link and the Windsurf IDE opens immediately for training.

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

### Getting Started - One-Click Windsurf IDE Access

1. **Click the link** provided by your administrator
   - No login or GitHub account required
   - No installation or setup needed

2. **The Windsurf IDE loads automatically**
   - The Windsurf IDE web interface opens in your browser
   - You'll see the full-featured Windsurf coding environment
   - No commands to run - it's all automatic

3. **Start coding immediately**
   - Access your dataset at `/app/data/dataset.csv`
   - Use all Windsurf IDE features without configuration
   - All AI assistance features are ready to use

4. **Build and test directly in Windsurf**
   - Create visualizations with the built-in tools
   - Run code and see results instantly
   - Get AI assistance with your Windsurf workflows

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
