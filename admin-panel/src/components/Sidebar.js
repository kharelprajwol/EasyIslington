// src/components/Sidebar.js

import React from 'react';
import './Sidebar.css';


function Sidebar({ onSelection }) {
  return (
      <div className="sidebar">
          <ul>
              <li onClick={() => onSelection('students')}><a href="#">Students</a></li>
              <li onClick={() => onSelection('admins')}><a href="#">Admins</a></li>
              <li onClick={() => onSelection('schedules')}><a href="#">Schedules</a></li>
              <li onClick={() => onSelection('changePassword')}><a href="#">Change Password</a></li>
              <li onClick={() => onSelection('logout')}><a href="#">Logout</a></li>
              {/* ... other list items */}
          </ul>
      </div>
  );
}

export default Sidebar;
