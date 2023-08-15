import React, { useState } from 'react';
import './ChangePassword.css';

function ChangePassword() {
    const [newPassword, setNewPassword] = useState('');

    const handleChange = (e) => {
        setNewPassword(e.target.value);
    }

    const handleSubmit = async () => {
        if (!newPassword) {
            alert('Please enter a new password!');
            return;
        }

        try {
            const adminId = "your_admin_id_here";
            const response = await fetch(`http://localhost:3000/admin/change-admin-password/${adminId}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ newPassword })
            });

            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            const responseData = await response.json();

            if (responseData.success) {
                alert('Password changed successfully!');
                setNewPassword(''); // Clear the input field
            } else {
                alert('Failed to change password!'); // Handle the failed password change
            }
        } catch (error) {
            console.error('Error changing password:', error);
            alert('An error occurred while changing the password.');  // Show error message
        }
    }

    return (
        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', marginTop: '100px' }}>
            <label style={{ marginBottom: '10px' }}>
                Enter New Password:
                <input
                    type="password"
                    value={newPassword}
                    onChange={handleChange}
                    style={{ marginLeft: '10px' }}
                />
            </label>
            <button onClick={handleSubmit}>Change</button>
        </div>
    );
}

export default ChangePassword;
