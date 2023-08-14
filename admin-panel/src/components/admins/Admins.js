import React, { useState, useEffect } from 'react';
import './Admins.css';

function Admins() {
    const [admins, setAdmins] = useState([
    ]);

    const [newAdmin, setNewAdmin] = useState({fullName: '', email: '', username: '', password: '' });
    const [open, setOpen] = useState(false);
    const [editIndex, setEditIndex] = useState(-1);

    useEffect(() => {
        const fetchAdmins = async () => {
            try {
                const response = await fetch('http://localhost:3000/admin/admins');

                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }

                const data = await response.json();

                if (data && data.success) {
                    setAdmins(data.data);
                } else {
                    console.error(data.message || 'Error fetching admins.');
                }
            } catch (error) {
                console.error('There was a problem with the fetch operation:', error.message);
            }
        };

        fetchAdmins();
    }, []);

    const generatePasswordForNewAdmin = () => {
        const password = "demo" + Math.floor(1000 + Math.random() * 9000);
        setNewAdmin({ ...newAdmin, password });
    };

    const handleAddAdmin = async () => {
        try {
            const response = await fetch('http://localhost:3000/admin/add-admin', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(newAdmin)
            });

            console.log(response);
    
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
    
            const data = await response.json();
    
            if (data && data.success) {
                setAdmins([...admins, newAdmin]);
                // If you also want to send an email, add your email sending logic here.
                setNewAdmin({ fullName: '', email: '', username: '', password: '' });
                setOpen(false);
            } else {
                // Handle any potential errors that come from the server (e.g., validation errors).
                console.error(data.message || 'Error adding admin.');
            }
        } catch (error) {
            console.error('There was a problem with the fetch operation:', error.message);
        }
    };
    

    const handleEditAdmin = async () => {
        if (editIndex !== -1) {
            const adminToUpdate = admins[editIndex];
            try {
                const response = await fetch(`http://localhost:3000/admin/edit-admin/${adminToUpdate._id}`, {
                    method: 'PUT', // or 'PATCH' depending on your backend implementation
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(newAdmin)
                });
    
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
    
                const data = await response.json();
    
                if (data && data.success) {
                    const updatedAdmins = [...admins];
                    updatedAdmins[editIndex] = newAdmin;
                    setAdmins(updatedAdmins);
                    setNewAdmin({ fullName: '', email: '', username: '', password: '' });
                    setOpen(false);
                    setEditIndex(-1);
                } else {
                    console.error(data.message || 'Error editing admin.');
                }
            } catch (error) {
                console.error('There was a problem with the fetch operation:', error.message);
            }
        }
    };

    const handleResetPassword = async (index) => {
        const adminToReset = admins[index];
        // Generate a new password or handle it differently as per your needs
        const newPassword = "reset" + Math.floor(1000 + Math.random() * 9000);
    
        try {
            const response = await fetch(`http://localhost:3000/admin/reset-password/${adminToReset._id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ password: newPassword })
            });
    
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
    
            const data = await response.json();
    
            if (data && data.success) {
                alert(`Password for ${adminToReset.username} has been reset to ${newPassword}`);
            } else {
                console.error(data.message || 'Error resetting password.');
            }
        } catch (error) {
            console.error('There was a problem with the fetch operation:', error.message);
        }
    };
    
    

    const handleDeleteAdmin = async (index) => {
        console.log('in delete admin dunction');
        if (window.confirm('Are you sure you want to delete this admin?')) {
            try {
                const adminToDelete = admins[index];
                console.log(adminToDelete);
                
                // Assuming you have an endpoint that accepts DELETE requests and the ID of the admin as a parameter.
                const response = await fetch(`http://localhost:3000/admin/delete-admin/${adminToDelete._id}`, {
                    method: 'DELETE',
                });
    
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
    
                const data = await response.json();
    
                if (data && data.success) {
                    const updatedAdmins = admins.filter((_, i) => i !== index);
                    setAdmins(updatedAdmins);
                } else {
                    // Handle any potential errors that come from the server.
                    console.error(data.message || 'Error deleting admin.');
                }
    
            } catch (error) {
                console.error('There was a problem with the fetch operation:', error.message);
            }
        }
    };
    

    return (
        <div>
            <button className="add-button" onClick={() => { setOpen(true); setEditIndex(-1); setNewAdmin({ name: '', email: '', username: '', password: '' }); }}>
                Add Admin
            </button>

            {(open || editIndex !== -1) && (
                <div className="modal-overlay">
                    <div className="modal-content">
                        <div className="label-input-group">
                            <label>Name:</label>
                            <input
                                type="text"
                                value={newAdmin.fullName}
                                onChange={(e) => setNewAdmin({ ...newAdmin, fullName: e.target.value })}
                            />
                        </div>
                        <div className="label-input-group">
                            <label>Email:</label>
                            <input
                                type="email"
                                value={newAdmin.email}
                                onChange={(e) => setNewAdmin({ ...newAdmin, email: e.target.value })}
                            />
                        </div>
                        <div className="label-input-group">
                            <label>Username:</label>
                            <input
                                type="text"
                                value={newAdmin.username}
                                onChange={(e) => setNewAdmin({ ...newAdmin, username: e.target.value })}
                            />
                        </div>
                        {editIndex === -1 && (
                            <>
                                <button onClick={generatePasswordForNewAdmin}>
                                    Generate Password
                                </button>
                                <p>Password: {newAdmin.password}</p>
                            </>
                        )}
                        <button onClick={editIndex !== -1 ? handleEditAdmin : handleAddAdmin}>
                            {editIndex !== -1 ? 'Save Changes' : 'Add and Send Credentials'}
                        </button>
                        <button onClick={() => { setEditIndex(-1); setOpen(false); }}>Cancel</button>
                    </div>
                </div>
            )}

            <table className="admins-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Username</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {admins.map((admin, index) => (
                        <tr key={index}>
                        <td>{admin.fullName}</td>
                        <td>{admin.email}</td>
                        <td>{admin.username}</td>
                        <td>
                            <button onClick={() => {
                                setEditIndex(index);
                                setNewAdmin({ fullName: admin.fullName, email: admin.email, username: admin.username, password: admin.password });
                                setOpen(true);
                            }}>
                                Edit Details
                            </button>
                            <button onClick={() => handleResetPassword(index)}>
                                Reset Password
                            </button>
                            <button onClick={() => handleDeleteAdmin(index)}>
                                Delete Admin
                            </button>
                        </td>
                    </tr>
                    
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export default Admins;
