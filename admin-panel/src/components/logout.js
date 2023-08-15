import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

function Logout() {
    const navigate = useNavigate();

    useEffect(() => {
        const result = window.confirm('Admin, are you sure you want to logout?');

        if (result) {
            
            localStorage.removeItem('adminToken');
            // Navigate to the login page or main page
            navigate('/');
        } else {
            // If not logging out, navigate back to where they came from or the dashboard
            navigate('/home'); // assuming you have a dashboard route
        }
    }, [navigate]);  // the dependency array ensures this effect runs only once

    return null;  // This component doesn't render anything visually
}

export default Logout;
