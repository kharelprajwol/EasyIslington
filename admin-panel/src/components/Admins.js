import React, { useState } from 'react';
import './Admins.css';

function Admins() {
    // Initial data now includes username and password
    const [admins, setAdmins] = useState([
        { name: 'Admin 1', email: 'admin1@example.com', username: 'admin1', password: 'pass1234' },
        { name: 'Admin 2', email: 'admin2@example.com', username: 'admin2', password: 'pass5678' }
    ]);
    
    const [newAdmin, setNewAdmin] = useState({ name: '', email: '', username: '', password: '' });
    const [open, setOpen] = useState(false);
    const [editIndex, setEditIndex] = useState(-1);
    const [resetPassword, setResetPassword] = useState('');
    const [copied, setCopied] = useState(false);
    const [sentEmail, setSentEmail] = useState(false);
    const [visiblePasswordIndex, setVisiblePasswordIndex] = useState(-1);


    const handleAddAdmin = () => {
        setAdmins([...admins, newAdmin]);
        setNewAdmin({ name: '', email: '', username: '', password: '' });
        setOpen(false);
    };

    const handleEditAdmin = () => {
        if (editIndex !== -1) {
            const updatedAdmins = [...admins];
            updatedAdmins[editIndex] = newAdmin;
            setAdmins(updatedAdmins);
            setNewAdmin({ name: '', email: '', username: '', password: '' });
            setEditIndex(-1);
            setOpen(false);
        }
    };

    const handleCloseModal = () => {
        setResetPassword('');
        setSentEmail(false);
        setCopied(false);
        setOpen(false);
    };

    const handleDeleteAdmin = (index) => {
        if (window.confirm('Are you sure you want to delete this admin?')) {
            const updatedAdmins = admins.filter((_, i) => i !== index);
            setAdmins(updatedAdmins);
        }
    };

    const generatePassword = () => {
        // ... [Rest of the password generation logic]
    };

    const handleSendPassword = (email, password) => {
        // ... [Rest of the sending password logic]
    };

    return (
        <div>
            <button className="add-button" onClick={() => { setOpen(true); setEditIndex(-1); setNewAdmin({ name: '', email: '', username: '', password: '' }); }}>
                Add Admin
            </button>

            {/* Add/Edit Admin Modal */}
            {(open || editIndex !== -1) && (
                <div className="modal-overlay">
                    <div className="modal-content">
                        <div className="label-input-group">
                            <label>Name:</label>
                            <input
                                type="text"
                                value={newAdmin.name}
                                onChange={(e) => setNewAdmin({ ...newAdmin, name: e.target.value })}
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
                        <div className="label-input-group">
                            <label>Password:</label>
                            <input
                                type="password"
                                value={newAdmin.password}
                                onChange={(e) => setNewAdmin({ ...newAdmin, password: e.target.value })}
                            />
                        </div>
                        <button onClick={editIndex !== -1 ? handleEditAdmin : handleAddAdmin}>
                            {editIndex !== -1 ? 'Save Changes' : 'Add'}
                        </button>
                        <button onClick={() => { setEditIndex(-1); setOpen(false); }}>Cancel</button>
                    </div>
                </div>
            )}

            {/* Reset Password Modal */}
            {/* ... [Your Reset Password Modal remains unchanged] */}

            {/* Admins Table */}
<table className="admins-table">
    <thead>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Username</th>
            <th>Password</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        {admins.map((admin, index) => (
            <tr key={index}>
                <td>{admin.name}</td>
                <td>{admin.email}</td>
                <td>{admin.username}</td>
                <td>
                    {visiblePasswordIndex === index ? admin.password : '•'.repeat(admin.password.length)}
                    <span 
                        onClick={() => 
                            setVisiblePasswordIndex(visiblePasswordIndex === index ? -1 : index)
                        }
                        style={{ cursor: "pointer" }}>
                        {visiblePasswordIndex === index ? '🚫👁' : '👁'}
                    </span>
                </td>
                <td>
                    <button
                        onClick={() => {
                            setEditIndex(index);
                            setNewAdmin({ name: admin.name, email: admin.email, username: admin.username, password: admin.password });
                            setOpen(true);
                        }}
                    >
                        Edit Details
                    </button>
                    <button onClick={generatePassword}>Reset Password</button>
                    <button onClick={() => handleDeleteAdmin(index)}>Delete Admin</button>
                </td>
            </tr>
        ))}
    </tbody>
</table>

        </div>
    );
}

export default Admins;
