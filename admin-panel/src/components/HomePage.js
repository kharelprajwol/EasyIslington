import React, { useState } from 'react';
import Sidebar from './Sidebar';
import Students from './Students'; // Ensure Dashboard is correctly imported
import Admins from './Admins';
import Schedules from './Schedules';

import './HomePage.css';

function HomePage() {
    const [selectedComponent, setSelectedComponent] = useState('dashboard');

    const handleSelection = (component) => {
        setSelectedComponent(component);
    };

    const renderComponent = () => {
        switch (selectedComponent) {
            case 'students':
                return <Students />;
            case 'admins':
                return <Admins />;
            case 'schedules':
                return <Schedules />;    
            // Add cases for other components when imported
            default:
                return <Students />;
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
