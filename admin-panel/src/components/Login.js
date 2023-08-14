import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Login.css'; 

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

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    try {
      const response = await fetch('http://localhost:3000/admin/login-admin', { 
        method: 'POST',
        body: JSON.stringify(credentials),
        headers: { 'Content-Type': 'application/json' },
      });
      
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }

      const data = await response.json();

      if (data.success) {
        // Optionally store the token if the server sends one
        // For example: localStorage.setItem('token', data.token);
        navigate('/home');
      } else {
        alert(data.message || 'Invalid username or password');
      }

    } catch (error) {
      console.error('Error:', error);
      alert('Something went wrong. Please try again later.');
    }
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
