// JavaScript for Windsurf Training Portal

document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('login-form');
    const environmentInfo = document.getElementById('environment-info');
    const environmentLink = document.getElementById('environment-link');
    
    // Handle form submission
    loginForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Get form values
        const email = document.getElementById('email').value;
        const name = document.getElementById('name').value;
        const session = document.getElementById('session').value;
        
        // In a real implementation, this would make an API call to assign a pod
        // For this demo, we'll simulate the assignment with a timeout
        loginForm.innerHTML = '<div class="loading">Preparing your environment... <div class="spinner"></div></div>';
        
        setTimeout(function() {
            // Generate a unique identifier based on email (in production, use a proper assignment system)
            const userId = btoa(email).replace(/[^a-zA-Z0-9]/g, '').substring(0, 10);
            
            // Set the environment link (in production, this would be dynamically assigned)
            // Format: http://user-[id].localhost
            const envUrl = `http://user-${userId}.localhost`;
            environmentLink.href = envUrl;
            environmentLink.textContent = `Open Windsurf Environment (${name})`;
            
            // Show the environment info section
            loginForm.parentElement.classList.add('hidden');
            environmentInfo.classList.remove('hidden');
            
            // In a real implementation, log this assignment to a database
            console.log(`User ${name} (${email}) assigned to environment: ${envUrl} for ${session} session`);
            
        }, 2000); // Simulate loading time
    });
});
