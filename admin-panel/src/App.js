import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
//import Dashboard from './components/Dashboard';
import Login from './components/Login';
import HomePage from './components/HomePage'; // Import the HomePage component

function App() {
  return (
    <div>
      <Router>
        <Routes>
          <Route path="/" element={<Login />} />
          <Route path="/home" element={<HomePage />}/>
        </Routes>
      </Router>
    </div>
  );
}

export default App;
