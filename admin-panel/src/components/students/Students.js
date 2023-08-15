import React, { useState, useEffect } from 'react';
import './Students.css';

function Students() {
    const [searchQuery, setSearchQuery] = useState('');
    const [specializationFilter, setSpecializationFilter] = useState('');
    const [yearFilter, setYearFilter] = useState('');
    const [semesterFilter, setSemesterFilter] = useState('');
    const [groupFilter, setgroupFilter] = useState('');
    const [students, setStudents] = useState([]);
    const [newPasswordModalOpen, setNewPasswordModalOpen] = useState(false);
const [newPassword, setNewPassword] = useState("");

let filteredStudents = [];

    useEffect(() => {
        fetch('http://localhost:3000/admin/students')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                setStudents(data.data); // Use data.data instead of just data
                console.log(data.data) // Update this as well
            })
            .catch(error => {
                console.log("There was a problem with the fetch operation:", error.message);
            });
    }, []); 
    

    

    if (Array.isArray(students)) {
        filteredStudents = students.filter(student => {
            const isSpecializationMatch = !specializationFilter || student.specialization === specializationFilter;
            const isYearMatch = !yearFilter || student.year === yearFilter;
            const isSemesterMatch = !semesterFilter || student.semester === semesterFilter;
            const isgroupMatch = !groupFilter || student.group === groupFilter;
            
            const isSearchMatch = !searchQuery || Object.values(student).some(val => 
                String(val).toLowerCase().includes(searchQuery.toLowerCase())
            );
    
            return isSpecializationMatch && isYearMatch && isSemesterMatch && isgroupMatch && isSearchMatch;
        });
    }
    


    // State to control the modal for editing students
    const [isEditModalOpen, setIsEditModalOpen] = useState(false);
    const [selectedStudentIndex, setSelectedStudentIndex] = useState(null);
    const [editedStudent, setEditedStudent] = useState({
        name: '',
        specialization: '',
        year: '',
        semester: '',
        group: ''
    });

    const handleEditStudent = (index) => {
        setSelectedStudentIndex(index);
        setEditedStudent(filteredStudents[index]);
        setIsEditModalOpen(true);
    };

    const handleSaveEdit = () => {
        // Sending updated data to the server.
        fetch(`http://localhost:3000/admin/edit-student/${editedStudent._id}`, { 
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(editedStudent)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            if (data.success) { // Assuming the API responds with a 'success' field.
                const updatedStudents = [...students];
                updatedStudents[selectedStudentIndex] = data.student || editedStudent; // Using updated data from server or from local state.
                setStudents(updatedStudents);
                setIsEditModalOpen(false);
            } else {
                // Handle any errors that the server sends back.
                console.error(data.message || 'Error updating student.');
            }
        })
        .catch(error => {
            console.error("There was a problem with the fetch operation:", error.message);
        });
    };
    

    const generateRandomPassword = (length = 8) => {
        const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        let password = "";
        for (let i = 0; i < length; i++) {
            const randomIndex = Math.floor(Math.random() * charset.length);
            password += charset[randomIndex];
        }
        return password;
    }
    
    const handleResetStudentPassword = (index) => {
        const studentId = filteredStudents[index]._id;
        const generatedPassword = generateRandomPassword();
        fetch(`http://localhost:3000/admin/reset-student-password/${studentId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ newPassword: generatedPassword })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            if (data.success) {
                console.log('Password reset successfully.');
                setNewPassword(generatedPassword);
                setNewPasswordModalOpen(true);
            } else {
                console.error('Error resetting password:', data.message);
            }
        })
        .catch(error => {
            console.error("There was a problem with the fetch operation:", error.message);
        });
    };

    const handleSendEmail = async () => {
        // Logic to send newPassword via email.
        try {
            // Your logic to send email goes here...
            // Example:
            // await sendEmailFunction(newPassword);
    
            console.log("Password sent via email!");
        } catch (error) {
            console.error("Error sending password via email:", error);
        }
    };
    

    return (
        <div>
            {/* Filter & Search group */}
            <div className="filter-bar">
                <input 
                    type="text" 
                    placeholder="Search..." 
                    value={searchQuery} 
                    onChange={(e) => setSearchQuery(e.target.value)} 
                />
                
                <select className="dropdown" onChange={(e) => setSpecializationFilter(e.target.value)}>
                    <option value="">All Specializations</option>
                    <option value="BSc (Hons) Computing">BSc (Hons) Computing</option>
                    <option value="BSc (Hons) Computer Networking & IT Security">BSc (Hons) Computer Networking & IT Security</option>
                    <option value="BSc (Hons) Multimedia Technologies">BSc (Hons) Multimedia Technologies</option>
                    {/* ... Add other specializations */}
                </select>
                <select className="dropdown" onChange={(e) => setYearFilter(e.target.value)}>
                    <option value="">All Years</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="2">3</option>
                    {/* ... Add other years */}
                </select>
                <select className="dropdown" onChange={(e) => setSemesterFilter(e.target.value)}>
                    <option value="">All Semesters</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    {/* ... Add other semesters */}
                </select>
                <select className="dropdown" onChange={(e) => setgroupFilter(e.target.value)}>
                    <option value="">All groups</option>
                    <option value="C12">C12</option>
                    <option value="C15">C15</option>
                    {/* ... Add other groups */}
                </select>
            </div>

            <table className="students-table">
    <thead>
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th> {/* Added Email column */}
            <th>Username</th> {/* Added Username column */}
            <th>Specialization</th>
            <th>Year</th>
            <th>Semester</th>
            <th>group</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        {filteredStudents.map((student, index) => (
            <tr key={index}>
                <td>{student.firstName}</td>
                <td>{student.lastName}</td>
                <td>{student.email}</td> {/* Display Email */}
                <td>{student.username}</td> {/* Display Username */}
                <td>{student.specialization}</td>
                <td>{student.year}</td>
                <td>{student.semester}</td>
                <td>{student.group}</td>
                <td>
                    <button onClick={() => handleEditStudent(index)}>Edit Details</button>
                    <button onClick={() => handleResetStudentPassword(index)}>Reset Password</button>
                </td>
            </tr>
        ))}
    </tbody>
</table>



            {/* Edit Modal */}
{isEditModalOpen && (
    <div className="modal-overlay">
        <div className="modal-content">
            
            <div className="label-input-group">
                <label>First Name:</label>
                <input
                    type="text"
                    value={editedStudent.firstName}
                    onChange={(e) => setEditedStudent(prev => ({ ...prev, firstName: e.target.value }))}
                />
            </div>
            
            <div className="label-input-group">
                <label>Last Name:</label>
                <input
                    type="text"
                    value={editedStudent.lastName}
                    onChange={(e) => setEditedStudent(prev => ({ ...prev, lastName: e.target.value }))}
                />
            </div>

            <div className="label-input-group">
                <label>Email:</label>
                <input
                    type="text"
                    value={editedStudent.email}
                    disabled // This ensures the field cannot be edited
                />
            </div>

            <div className="label-input-group">
                <label>Username:</label>
                <input
                    type="text"
                    value={editedStudent.username}
                    disabled // This ensures the field cannot be edited
                />
            </div>
            
            <div className="label-input-group">
                <label>Specialization:</label>
                <input
                    type="text"
                    value={editedStudent.specialization}
                    onChange={(e) => setEditedStudent(prev => ({ ...prev, specialization: e.target.value }))}
                />
            </div>
            
            <div className="label-input-group">
                <label>Year:</label>
                <input
                    type="text"
                    value={editedStudent.year}
                    onChange={(e) => setEditedStudent(prev => ({ ...prev, year: e.target.value }))}
                />
            </div>

            <div className="label-input-group">
                <label>Semester:</label>
                <input
                    type="text"
                    value={editedStudent.semester}
                    onChange={(e) => setEditedStudent(prev => ({ ...prev, semester: e.target.value }))}
                />
            </div>

            <div className="label-input-group">
                <label>group:</label>
                <input
                    type="text"
                    value={editedStudent.group}
                    onChange={(e) => setEditedStudent(prev => ({ ...prev, group: e.target.value }))}
                />
            </div>

            <div className="button-group">
                <button onClick={handleSaveEdit}>Save</button>
                <button onClick={() => setIsEditModalOpen(false)}>Cancel</button>
            </div>
        </div>
    </div>
)}

{newPasswordModalOpen && (
    <div className="modal-overlay">
        <div className="modal-content">
            <p>New password: <strong>{newPassword}</strong></p>
            {/* New button for sending via email */}
            <button onClick={handleSendEmail}>Share</button>
            <button onClick={() => setNewPasswordModalOpen(false)}>Close</button>

            
        </div>
    </div>
)}




        </div>
    );
}

export default Students;
