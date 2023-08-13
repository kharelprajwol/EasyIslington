// src/components/Login.js

import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Login.css';  // Import the CSS

function Login() {
  const [credentials, setCredentials] = useState({
    username: '',
    password: ''
  });

  const navigate = useNavigate();

  const handleChange = (e) => {
    const { name, value } = e.target;
    setCredentials(prevState => ({
      ...prevState,
      [name]: value
    }));
  }

  const handleSubmit = (e) => {
    e.preventDefault();
    
    // Dummy check for specific username and password
    if (credentials.username === 'admin' && credentials.password === 'password') {
        navigate('/home');
      } else {
        alert('Invalid username or password');
      }
      

    // TODO: Use an actual POST method to validate login credentials
    // fetch('/api/login', { 
    //   method: 'POST',
    //   body: JSON.stringify(credentials),
    //   headers: { 'Content-Type': 'application/json' },
    // })
    // .then(response => response.json())
    // .then(data => {
    //   if (data.success) {
    //     navigate('/dashboard');
    //   } else {
    //     alert('Invalid username or password');
    //   }
    // })
    // .catch(error => {
    //   console.error('Error:', error);
    // });
  }

  return (
    <div className="login-container">
      <form className="login-form" onSubmit={handleSubmit}>
        <div>
          <label htmlFor="username">Username: </label>
          <input 
            type="text" 
            id="username" 
            name="username" 
            value={credentials.username} 
            onChange={handleChange} 
            required 
          />
        </div>
        <div>
          <label htmlFor="password">Password: </label>
          <input 
            type="password" 
            id="password" 
            name="password" 
            value={credentials.password} 
            onChange={handleChange} 
            required 
          />
        </div>
        <button type="submit">Login</button>
      </form>
    </div>
  );
}

export default Login;
