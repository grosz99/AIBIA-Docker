# Windsurf Training Environment

## Overview
This repository contains a ready-to-use Windsurf training environment for approximately 100 users simultaneously. Each user gets their own isolated environment with Windsurf pre-loaded and ready to use immediately. No setup or configuration required - just click and start using Windsurf!

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

### Getting Started - One-Click Access

1. **Click the link** provided by your administrator
   - No login or GitHub account required
   - No installation needed

2. **Wait briefly** while your personal environment loads
   - Everything is pre-configured for you
   - Windsurf starts automatically

3. **Start using Windsurf immediately**
   - The interface opens automatically in your browser
   - Your dataset is already loaded at `/app/data/dataset.csv`
   - All tools and features are ready to use

4. **Explore and build dashboards**
   - Create visualizations with the pre-loaded dataset
   - Build interactive dashboards
   - Experiment with different chart types and filters

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
