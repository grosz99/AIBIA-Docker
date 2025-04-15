#!/bin/bash

echo "Windsurf CLI (Training Version)"

COMMAND="$1"

if [ "$COMMAND" = "start" ]; then
    echo "Starting Windsurf environment..."
    echo "Setting up training environment with dataset..."
    
    # Create a more polished index.html if it doesn't exist
    if [ ! -f /workspace/index.html ]; then
        # Copy our pre-made index.html if it exists
        if [ -f /app/index.html ]; then
            cp /app/index.html /workspace/index.html
        else
            # Create a basic interface
            cat > /workspace/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Windsurf Training Environment</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        header {
            background-color: #28a745;
            color: white;
            padding: 1rem;
            text-align: center;
        }
        
        h1, h2, h3 {
            color: #28a745;
        }
        
        .dashboard {
            display: grid;
            grid-template-columns: 250px 1fr;
            gap: 20px;
            margin-top: 20px;
        }
        
        .sidebar {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .main-content {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            margin: 5px 0;
        }
        
        button:hover {
            background-color: #218838;
        }
        
        footer {
            margin-top: 40px;
            text-align: center;
            padding: 20px;
            color: #666;
            border-top: 1px solid #ddd;
        }
        
        .loading {
            display: none;
            text-align: center;
            margin: 20px 0;
        }
        
        .spinner {
            border: 4px solid #f3f3f3;
            border-top: 4px solid #28a745;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            animation: spin 2s linear infinite;
            margin: 10px auto;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <header>
        <h1>Windsurf Training Environment</h1>
        <p>Build and explore business intelligence dashboards</p>
    </header>
    
    <div class="container">
        <div class="main-content">
            <h2>Welcome to Your Windsurf Training Session</h2>
            <p>This environment is pre-configured with everything you need for the training.</p>
            
            <h3>Getting Started</h3>
            <p>Your dataset is already loaded and Windsurf is running. Use the tools below to start working:</p>
            
            <div style="display: flex; gap: 10px; flex-wrap: wrap; margin: 20px 0;">
                <button onclick="showDataset()">View Dataset</button>
                <button onclick="createDashboard()">Create Dashboard</button>
                <button onclick="showExamples()">Example Visualizations</button>
                <button onclick="showHelp()">Help & Documentation</button>
            </div>
            
            <div id="content-area">
                <p>Select an option above to get started with your training.</p>
            </div>
            
            <div id="loading" class="loading">
                <div class="spinner"></div>
                <p>Loading...</p>
            </div>
        </div>
    </div>
    
    <footer>
        <p>Windsurf Training Environment - Created for your training session</p>
    </footer>
    
    <script>
        function showLoading() {
            document.getElementById('loading').style.display = 'block';
            document.getElementById('content-area').innerHTML = '';
        }
        
        function hideLoading() {
            document.getElementById('loading').style.display = 'none';
        }
        
        function showDataset() {
            showLoading();
            setTimeout(() => {
                hideLoading();
                document.getElementById('content-area').innerHTML = `
                    <h3>Dataset Explorer</h3>
                    <p>Your training dataset is located at <code>/app/data/dataset.csv</code></p>
                    <p>Here's a preview of the first few rows:</p>
                    <div style="overflow-x: auto;">
                        <table style="width: 100%; border-collapse: collapse;">
                            <thead>
                                <tr style="background-color: #f2f2f2;">
                                    <th style="border: 1px solid #ddd; padding: 8px; text-align: left;">ID</th>
                                    <th style="border: 1px solid #ddd; padding: 8px; text-align: left;">Value</th>
                                    <th style="border: 1px solid #ddd; padding: 8px; text-align: left;">Category</th>
                                    <th style="border: 1px solid #ddd; padding: 8px; text-align: left;">Timestamp</th>
                                    <th style="border: 1px solid #ddd; padding: 8px; text-align: left;">Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="border: 1px solid #ddd; padding: 8px;">1</td>
                                    <td style="border: 1px solid #ddd; padding: 8px;">42.5</td>
                                    <td style="border: 1px solid #ddd; padding: 8px;">A</td>
                                    <td style="border: 1px solid #ddd; padding: 8px;">2025-01-15</td>
                                    <td style="border: 1px solid #ddd; padding: 8px;">active</td>
                                </tr>
                                <tr style="background-color: #f9f9f9;">
                                    <td style="border: 1px solid #ddd; padding: 8px;">2</td>
                                    <td style="border: 1px solid #ddd; padding: 8px;">18.3</td>
                                    <td style="border: 1px solid #ddd; padding: 8px;">B</td>
                                    <td style="border: 1px solid #ddd; padding: 8px;">2025-01-16</td>
                                    <td style="border: 1px solid #ddd; padding: 8px;">inactive</td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid #ddd; padding: 8px;">3</td>
                                    <td style="border: 1px solid #ddd; padding: 8px;">73.1</td>
                                    <td style="border: 1px solid #ddd; padding: 8px;">A</td>
                                    <td style="border: 1px solid #ddd; padding: 8px;">2025-01-17</td>
                                    <td style="border: 1px solid #ddd; padding: 8px;">active</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <p style="margin-top: 20px;">To work with this dataset in your training exercises, you can access it directly from the file system or use the Windsurf data tools.</p>
                `;
            }, 800);
        }
        
        function createDashboard() {
            showLoading();
            setTimeout(() => {
                hideLoading();
                document.getElementById('content-area').innerHTML = `
                    <h3>Create New Dashboard</h3>
                    <p>Use the form below to create a new dashboard:</p>
                    <form id="dashboard-form" onsubmit="return false;">
                        <div style="margin-bottom: 15px;">
                            <label for="dashboard-name" style="display: block; margin-bottom: 5px;">Dashboard Name:</label>
                            <input type="text" id="dashboard-name" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;" placeholder="My Training Dashboard">
                        </div>
                        
                        <div style="margin-bottom: 15px;">
                            <label for="dashboard-type" style="display: block; margin-bottom: 5px;">Dashboard Type:</label>
                            <select id="dashboard-type" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                                <option value="analytics">Analytics Dashboard</option>
                                <option value="operational">Operational Dashboard</option>
                                <option value="strategic">Strategic Dashboard</option>
                                <option value="tactical">Tactical Dashboard</option>
                            </select>
                        </div>
                        
                        <div style="margin-bottom: 15px;">
                            <label for="data-source" style="display: block; margin-bottom: 5px;">Data Source:</label>
                            <select id="data-source" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
                                <option value="dataset.csv">/app/data/dataset.csv</option>
                                <option value="sample">Sample Data</option>
                            </select>
                        </div>
                        
                        <div style="margin-bottom: 15px;">
                            <label style="display: block; margin-bottom: 5px;">Visualizations to Include:</label>
                            <div style="margin-left: 10px;">
                                <div style="margin-bottom: 5px;">
                                    <input type="checkbox" id="viz-bar" checked>
                                    <label for="viz-bar">Bar Chart</label>
                                </div>
                                <div style="margin-bottom: 5px;">
                                    <input type="checkbox" id="viz-line" checked>
                                    <label for="viz-line">Line Chart</label>
                                </div>
                                <div style="margin-bottom: 5px;">
                                    <input type="checkbox" id="viz-pie">
                                    <label for="viz-pie">Pie Chart</label>
                                </div>
                                <div style="margin-bottom: 5px;">
                                    <input type="checkbox" id="viz-table" checked>
                                    <label for="viz-table">Data Table</label>
                                </div>
                            </div>
                        </div>
                        
                        <button type="button" onclick="submitDashboard()">Create Dashboard</button>
                    </form>
                `;
            }, 800);
        }
        
        function submitDashboard() {
            const dashboardName = document.getElementById('dashboard-name').value || 'My Training Dashboard';
            showLoading();
            setTimeout(() => {
                hideLoading();
                document.getElementById('content-area').innerHTML = `
                    <h3>Dashboard Created Successfully!</h3>
                    <p>Your dashboard <strong>${dashboardName}</strong> has been created.</p>
                    <p>In a real Windsurf environment, you would now see your dashboard with the selected visualizations.</p>
                    <p>For this training environment, you can continue exploring the other features.</p>
                    <button onclick="showExamples()">View Example Visualizations</button>
                `;
            }, 1500);
        }
        
        function showExamples() {
            showLoading();
            setTimeout(() => {
                hideLoading();
                document.getElementById('content-area').innerHTML = `
                    <h3>Example Visualizations</h3>
                    <p>Here are some example visualizations you can create with Windsurf:</p>
                    
                    <div style="margin: 20px 0;">
                        <h4>Bar Chart Example</h4>
                        <div style="background-color: white; padding: 15px; border: 1px solid #ddd; border-radius: 4px;">
                            <svg width="100%" height="200" viewBox="0 0 600 200" style="background-color: white;">
                                <text x="300" y="20" text-anchor="middle" font-weight="bold">Category Distribution</text>
                                <line x1="50" y1="150" x2="550" y2="150" stroke="black" stroke-width="2"></line>
                                <line x1="50" y1="150" x2="50" y2="30" stroke="black" stroke-width="2"></line>
                                
                                <rect x="100" y="50" width="40" height="100" fill="#28a745"></rect>
                                <rect x="200" y="80" width="40" height="70" fill="#28a745"></rect>
                                <rect x="300" y="40" width="40" height="110" fill="#28a745"></rect>
                                <rect x="400" y="100" width="40" height="50" fill="#28a745"></rect>
                                
                                <text x="120" y="170" text-anchor="middle">A</text>
                                <text x="220" y="170" text-anchor="middle">B</text>
                                <text x="320" y="170" text-anchor="middle">C</text>
                                <text x="420" y="170" text-anchor="middle">D</text>
                            </svg>
                        </div>
                    </div>
                    
                    <div style="margin: 20px 0;">
                        <h4>Line Chart Example</h4>
                        <div style="background-color: white; padding: 15px; border: 1px solid #ddd; border-radius: 4px;">
                            <svg width="100%" height="200" viewBox="0 0 600 200" style="background-color: white;">
                                <text x="300" y="20" text-anchor="middle" font-weight="bold">Value Trend Over Time</text>
                                <line x1="50" y1="150" x2="550" y2="150" stroke="black" stroke-width="2"></line>
                                <line x1="50" y1="150" x2="50" y2="30" stroke="black" stroke-width="2"></line>
                                
                                <polyline points="100,120 200,80 300,130 400,60 500,90" fill="none" stroke="#28a745" stroke-width="3"></polyline>
                                <circle cx="100" cy="120" r="5" fill="#28a745"></circle>
                                <circle cx="200" cy="80" r="5" fill="#28a745"></circle>
                                <circle cx="300" cy="130" r="5" fill="#28a745"></circle>
                                <circle cx="400" cy="60" r="5" fill="#28a745"></circle>
                                <circle cx="500" cy="90" r="5" fill="#28a745"></circle>
                            </svg>
                        </div>
                    </div>
                    
                    <p>In the real Windsurf environment, you would be able to interact with these visualizations, filter data, and create custom dashboards.</p>
                `;
            }, 800);
        }
        
        function showHelp() {
            showLoading();
            setTimeout(() => {
                hideLoading();
                document.getElementById('content-area').innerHTML = `
                    <h3>Help & Documentation</h3>
                    
                    <h4>Training Environment</h4>
                    <p>This is a simulated Windsurf environment for training purposes. It provides a simplified interface to help you understand the core concepts.</p>
                    
                    <h4>Available Features</h4>
                    <ul>
                        <li><strong>View Dataset</strong> - Explore the training dataset</li>
                        <li><strong>Create Dashboard</strong> - Simulate creating a new dashboard</li>
                        <li><strong>Example Visualizations</strong> - View sample charts and graphs</li>
                        <li><strong>Help & Documentation</strong> - Access this help information</li>
                    </ul>
                    
                    <h4>Working with Data</h4>
                    <p>Your training dataset is located at <code>/app/data/dataset.csv</code>. In a real Windsurf environment, you would be able to:</p>
                    <ul>
                        <li>Import data from various sources</li>
                        <li>Clean and transform data</li>
                        <li>Create visualizations based on your data</li>
                        <li>Build interactive dashboards</li>
                        <li>Share insights with others</li>
                    </ul>
                    
                    <h4>Need More Help?</h4>
                    <p>If you have questions during the training session, please ask your instructor for assistance.</p>
                `;
            }, 800);
        }
    </script>
</body>
</html>
EOF
        fi
    fi
    
    # Create symbolic link to make data accessible via HTTP
    ln -sf /app/data /workspace/app/data 2>/dev/null || true
    
    # Start HTTP server
    cd /workspace
    python -m http.server 3000
elif [ "$COMMAND" = "help" ]; then
    echo "Windsurf CLI Help:"
    echo "  start     - Start the Windsurf environment"
    echo "  help      - Show this help message"
    echo "  version   - Show version information"
    echo "  dashboard - Create a new dashboard"
    echo "  data      - Manage data sources"
elif [ "$COMMAND" = "version" ]; then
    echo "Windsurf CLI v1.0.0 (Training Edition)"
elif [ "$COMMAND" = "dashboard" ]; then
    echo "Creating new dashboard..."
    echo "Dashboard created successfully!"
elif [ "$COMMAND" = "data" ]; then
    echo "Available data sources:"
    echo "  - /app/data/dataset.csv"
else
    echo "Unknown command: $COMMAND"
    echo "Try 'windsurf help' for a list of commands"
fi
