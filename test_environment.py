import os
import sys
import pandas as pd
import subprocess
import platform

def check_environment():
    """Verify that the Windsurf environment is properly configured."""
    results = {
        "status": "PASS",
        "checks": [],
        "errors": []
    }
    
    # Check Python version
    python_version = sys.version
    results["checks"].append(f"Python version: {python_version}")
    
    # Check installed packages
    required_packages = ["streamlit", "dash", "plotly", "pandas"]
    for package in required_packages:
        try:
            __import__(package)
            results["checks"].append(f"✓ {package} is installed")
        except ImportError:
            results["errors"].append(f"✗ {package} is not installed")
            results["status"] = "FAIL"
    
    # Check if dataset exists
    dataset_paths = [
        "/app/data/dataset.csv",
        "/workspace/app/data/dataset.csv",
        "./dataset.csv"
    ]
    
    dataset_found = False
    for path in dataset_paths:
        if os.path.exists(path):
            try:
                df = pd.read_csv(path)
                row_count = len(df)
                col_count = len(df.columns)
                results["checks"].append(f"✓ Dataset found at {path} with {row_count} rows and {col_count} columns")
                dataset_found = True
                break
            except Exception as e:
                results["errors"].append(f"✗ Error reading dataset at {path}: {str(e)}")
    
    if not dataset_found:
        results["errors"].append("✗ Dataset not found in any expected location")
        results["status"] = "FAIL"
    
    # Check if Windsurf CLI is installed
    try:
        if platform.system() == "Windows":
            windsurf_version = subprocess.check_output("where windsurf", shell=True).decode().strip()
        else:
            windsurf_version = subprocess.check_output("which windsurf", shell=True).decode().strip()
        results["checks"].append(f"✓ Windsurf CLI found at {windsurf_version}")
    except subprocess.CalledProcessError:
        results["errors"].append("✗ Windsurf CLI not found in PATH")
        results["status"] = "FAIL"
    
    # Check port availability
    ports_to_check = [8501] + list(range(3000, 3101))
    for port in ports_to_check[:3]:  # Just check a few ports for the test
        try:
            import socket
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.settimeout(1)
            result = sock.connect_ex(("127.0.0.1", port))
            if result != 0:
                results["checks"].append(f"✓ Port {port} is available")
            else:
                results["checks"].append(f"ℹ Port {port} is already in use")
            sock.close()
        except Exception as e:
            results["errors"].append(f"✗ Error checking port {port}: {str(e)}")
    
    return results

def print_results(results):
    """Print the environment check results in a formatted way."""
    print("\n" + "=" * 50)
    print(f"WINDSURF ENVIRONMENT TEST: {results['status']}")
    print("=" * 50)
    
    print("\nCHECKS:")
    for check in results["checks"]:
        print(f"  {check}")
    
    if results["errors"]:
        print("\nERRORS:")
        for error in results["errors"]:
            print(f"  {error}")
    
    print("\n" + "=" * 50)
    if results["status"] == "PASS":
        print("✅ Environment is ready for Windsurf training!")
    else:
        print("❌ Environment has issues that need to be addressed.")
    print("=" * 50 + "\n")

def create_sample_dashboard():
    """Create a simple sample dashboard using Streamlit."""
    dashboard_code = """
import streamlit as st
import pandas as pd
import plotly.express as px

# Set page configuration
st.set_page_config(page_title="Windsurf Training Dashboard", layout="wide")

# Add title and description
st.title("Windsurf Training Dashboard")
st.markdown("""This is a sample dashboard created for the Windsurf training session.  
              The dataset is preloaded and ready for exploration.""")

# Load the dataset
try:
    # Try different possible locations for the dataset
    for path in ["/app/data/dataset.csv", "/workspace/app/data/dataset.csv", "./dataset.csv"]:
        try:
            if pd.io.common.file_exists(path):
                df = pd.read_csv(path)
                st.success(f"Dataset loaded successfully from {path}")
                break
        except:
            continue
    else:
        st.error("Dataset not found in any expected location")
        df = pd.DataFrame()
        
    if not df.empty:
        # Display dataset info
        st.subheader("Dataset Information")
        col1, col2, col3 = st.columns(3)
        with col1:
            st.metric("Rows", len(df))
        with col2:
            st.metric("Columns", len(df.columns))
        with col3:
            st.metric("Memory Usage", f"{df.memory_usage(deep=True).sum() / (1024 * 1024):.2f} MB")
        
        # Display the first few rows of the dataset
        st.subheader("Data Preview")
        st.dataframe(df.head())
        
        # Column selection for visualization
        st.subheader("Data Visualization")
        
        # Only show numeric columns for visualization
        numeric_cols = df.select_dtypes(include=['number']).columns.tolist()
        
        if numeric_cols:
            # Create two columns for the controls
            col1, col2 = st.columns(2)
            
            with col1:
                x_axis = st.selectbox("X-axis", options=numeric_cols, index=0)
            
            with col2:
                y_axis = st.selectbox("Y-axis", options=numeric_cols, index=min(1, len(numeric_cols)-1))
            
            # Create a scatter plot
            fig = px.scatter(df, x=x_axis, y=y_axis, title=f"{y_axis} vs {x_axis}")
            st.plotly_chart(fig, use_container_width=True)
            
            # Create a histogram
            hist_col = st.selectbox("Select column for histogram", options=numeric_cols, index=0)
            fig = px.histogram(df, x=hist_col, title=f"Distribution of {hist_col}")
            st.plotly_chart(fig, use_container_width=True)
        else:
            st.warning("No numeric columns found in the dataset for visualization")
            
except Exception as e:
    st.error(f"Error: {str(e)}")
    st.info("This is a sample dashboard. In a real training session, you would build your own dashboards using the provided dataset.")
"""
    
    # Create the sample dashboard file
    with open("sample_dashboard.py", "w") as f:
        f.write(dashboard_code)
    
    print("\n" + "=" * 50)
    print("SAMPLE DASHBOARD CREATED")
    print("=" * 50)
    print("\nA sample Streamlit dashboard has been created as 'sample_dashboard.py'")
    print("To run it, use the command: streamlit run sample_dashboard.py")
    print("=" * 50 + "\n")

if __name__ == "__main__":
    print("Running Windsurf environment tests...")
    results = check_environment()
    print_results(results)
    
    # Create a sample dashboard
    create_sample_dashboard()
    
    print("Test complete! Use this script to verify each user's environment.")
    print("To deploy for 100 users, ensure your Gitpod account has sufficient resources.")
    print("Refer to the README.md for detailed deployment instructions.")
