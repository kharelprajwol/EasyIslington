import React, { useState } from 'react';
import Sidebar from './Sidebar';
import Dashboard from './Dashboard';
import ManageStudents from './ManageStudents'; // Ensure Dashboard is correctly imported
import ManageAdmins from './ManageAdmins';
import Programmes from './Programmes';
// ... import other components if needed...
import './HomePage.css';
import Schedules from './Schedules';

function HomePage() {
    const [selectedComponent, setSelectedComponent] = useState('dashboard');

    const handleSelection = (component) => {
        setSelectedComponent(component);
    };

    const renderComponent = () => {
        switch (selectedComponent) {
            case 'dashboard':
                return <Dashboard />;
            case 'programmes':
                return <Programmes />;
            case 'manage-students':
                return <ManageStudents />;
            case 'manage-admins':
                return <ManageAdmins />;
            case 'schedules':
                return <Schedules />;    
            // Add cases for other components when imported
            default:
                return <Dashboard />;
        }
    };

    return (
        <div className="home-container">
            <div className='side-bar'>
            <Sidebar onSelection={handleSelection} />
            </div>
            
            <div className="main-content">
                {renderComponent()}
            </div>
        </div>
    );
}

export default HomePage;
