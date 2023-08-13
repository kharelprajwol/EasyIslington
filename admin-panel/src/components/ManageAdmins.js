import React, { useState } from 'react';
import './ManageAdmins.css';

function ManageAdmins() {
    const [admins, setAdmins] = useState([
        { name: 'Admin 1', email: 'admin1@example.com' },
        { name: 'Admin 2', email: 'admin2@example.com' }
    ]); // Admin data
    const [newAdmin, setNewAdmin] = useState({ name: '', email: '' });
    const [open, setOpen] = useState(false);
    const [editIndex, setEditIndex] = useState(-1); // Index of admin being edited
    const [resetPassword, setResetPassword] = useState('');
    const [copied, setCopied] = useState(false); // State for tracking if password is copied
    const [sentEmail, setSentEmail] = useState(false); // State for tracking if email is sent


    const handleAddAdmin = () => {
        setAdmins([...admins, newAdmin]);
        setNewAdmin({ name: '', email: '' });
        setOpen(false);
    };

    const handleEditAdmin = () => {
        if (editIndex !== -1) {
            const updatedAdmins = [...admins];
            updatedAdmins[editIndex] = newAdmin;
            setAdmins(updatedAdmins);
            setNewAdmin({ name: '', email: '' });
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
        const uppercaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        const symbols = '!@#$%^&*';
        const allCharacters = uppercaseLetters + symbols + '0123456789';
        let password = '';

        for (let i = 0; i < 3; i++) {
            password += uppercaseLetters[Math.floor(Math.random() * uppercaseLetters.length)];
            password += symbols[Math.floor(Math.random() * symbols.length)];
            password += allCharacters[Math.floor(Math.random() * allCharacters.length)];
        }

        setResetPassword(password);
    };

    const handleSendPassword = (email, password) => {
        // In a real application, you would implement the logic to send an email here
        // For now, let's just log the email and password
        console.log(`Sending password "${password}" to ${email}`);
        setSentEmail(true); // Update the sentEmail state
    };

    return (
        <div>
            <button className="add-button" onClick={() => { setOpen(true); setEditIndex(-1); setNewAdmin({ name: '', email: '' }); }}>
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
                        <button onClick={editIndex !== -1 ? handleEditAdmin : handleAddAdmin}>
                            {editIndex !== -1 ? 'Save Changes' : 'Add'}
                        </button>
                        <button onClick={() => { setEditIndex(-1); setOpen(false); }}>Cancel</button>
                    </div>
                </div>
            )}

            {/* Reset Password Modal */}
{/* Reset Password Modal */}
{resetPassword && (
    <div className="modal-overlay">
        <div className="modal-content">
            <h2>Reset Password</h2>
            <p>Your new password is:</p>
            <div className="password-container">
                <p>{resetPassword}</p>
                <button className="copy-button" onClick={() => {
                                navigator.clipboard.writeText(resetPassword);
                                setCopied(true); // Update the copied state
                            }}>
                                {copied ? 'Copied' : 'Copy'}
                            </button>
            </div>
            <div className="button-group">
            <div className="button-group">
                            <button
                                className="send-button"
                                onClick={() => {
                                    handleSendPassword(newAdmin.email, resetPassword);
                                    setSentEmail(true); // Update the sentEmail state
                                }}
                                disabled={sentEmail} // Disable the button if email is already sent
                            >
                                {sentEmail ? 'Sent' : 'Send Password Via Email'}
                            </button>
                            <button className="ok-button" onClick={handleCloseModal}>OK</button>
                        </div>
                
            </div>
        </div>
    </div>
)}



            {/* Admins Table */}
            <table className="admins-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {admins.map((admin, index) => (
                        <tr key={index}>
                            <td>{admin.name}</td>
                            <td>{admin.email}</td>
                            <td>
                                <button
                                    onClick={() => {
                                        setEditIndex(index);
                                        setNewAdmin({ name: admin.name, email: admin.email });
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

export default ManageAdmins;
