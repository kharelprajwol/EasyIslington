import React, { useState } from 'react';
import Sidebar from './sidebar/Sidebar';
import Students from './students/Students'; 
import Admins from './admins/Admins';
import Schedules from './schedules/Schedules';
import Dashboard from './dashboard/Dashboard';
import Logout from './logout';
import ChangePassword from './changePassword';



import './HomePage.css';


function HomePage() {
    const [selectedComponent, setSelectedComponent] = useState('dashboard');

    const handleSelection = (component) => {
        setSelectedComponent(component);
    };

    const renderComponent = () => {
        switch (selectedComponent) {
            case 'dashboard':
                return <Dashboard />;
            case 'students':
                return <Students />;
            case 'admins':
                return <Admins />;
            case 'schedules':
                return <Schedules />;
            case 'changePassword':
                return <ChangePassword />;    
            case 'logout':
                return <Logout />;
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
