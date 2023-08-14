import React, { useState } from 'react';
import './Students.css';

function Students() {
    // Sample student data
    const [students, setStudents] = useState([
        {
            name: 'John Doe',
            specialization: 'Science',
            year: '1',
            semester: '2',
            section: 'A'
        }
        // ... add more sample data if needed ...
    ]); 
    const [searchQuery, setSearchQuery] = useState('');
    const [specializationFilter, setSpecializationFilter] = useState('');
    const [yearFilter, setYearFilter] = useState('');
    const [semesterFilter, setSemesterFilter] = useState('');
    const [sectionFilter, setSectionFilter] = useState('');

    const filteredStudents = students.filter(student => {
        return (
            (specializationFilter ? student.specialization === specializationFilter : true) &&
            (yearFilter ? student.year === yearFilter : true) &&
            (semesterFilter ? student.semester === semesterFilter : true) &&
            (sectionFilter ? student.section === sectionFilter : true) &&
            (searchQuery ? Object.values(student).some(val => 
                val.toString().toLowerCase().includes(searchQuery.toLowerCase())) : true)
        );
    });

    // State to control the modal for editing students
    const [isEditModalOpen, setIsEditModalOpen] = useState(false);
    const [selectedStudentIndex, setSelectedStudentIndex] = useState(null);
    const [editedStudent, setEditedStudent] = useState({
        name: '',
        specialization: '',
        year: '',
        semester: '',
        section: ''
    });

    const handleEditStudent = (index) => {
        setSelectedStudentIndex(index);
        setEditedStudent(filteredStudents[index]);
        setIsEditModalOpen(true);
    };

    const handleSaveEdit = () => {
        const updatedStudents = [...students];
        updatedStudents[selectedStudentIndex] = editedStudent;
        setStudents(updatedStudents);
        setIsEditModalOpen(false);
    };

    const handleDeleteStudent = (index) => {
        const newStudents = [...students];
        newStudents.splice(index, 1);
        setStudents(newStudents);
    };

    return (
        <div>
            {/* Filter & Search Section */}
            <div className="filter-bar">
                <input 
                    type="text" 
                    placeholder="Search..." 
                    value={searchQuery} 
                    onChange={(e) => setSearchQuery(e.target.value)} 
                />
                
                <select onChange={(e) => setSpecializationFilter(e.target.value)}>
                    <option value="">All Specializations</option>
                    <option value="Science">Science</option>
                    <option value="Arts">Arts</option>
                    {/* ... Add other specializations */}
                </select>
                <select onChange={(e) => setYearFilter(e.target.value)}>
                    <option value="">All Years</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    {/* ... Add other years */}
                </select>
                <select onChange={(e) => setSemesterFilter(e.target.value)}>
                    <option value="">All Semesters</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    {/* ... Add other semesters */}
                </select>
                <select onChange={(e) => setSectionFilter(e.target.value)}>
                    <option value="">All Sections</option>
                    <option value="A">A</option>
                    <option value="B">B</option>
                    {/* ... Add other sections */}
                </select>
            </div>

            {/* Students Table */}
            <table className="students-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Specialization</th>
                        <th>Year</th>
                        <th>Semester</th>
                        <th>Section</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {filteredStudents.map((student, index) => (
                        <tr key={index}>
                            <td>{student.name}</td>
                            <td>{student.specialization}</td>
                            <td>{student.year}</td>
                            <td>{student.semester}</td>
                            <td>{student.section}</td>
                            <td>
                                <button onClick={() => handleEditStudent(index)}>Edit Details</button>
                                <button onClick={() => handleDeleteStudent(index)}>Reset Password</button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            {/* Edit Modal */}
            {/* Edit Modal */}
            {isEditModalOpen && (
                <div className="modal-overlay">
                    <div className="modal-content">
                        <h2>Edit Student</h2>
                        <label>
                            Name:
                            <input
                                type="text"
                                value={editedStudent.name}
                                onChange={(e) => setEditedStudent(prev => ({ ...prev, name: e.target.value }))}
                            />
                        </label>
                        <label>
                            Specialization:
                            <input
                                type="text"
                                value={editedStudent.specialization}
                                onChange={(e) => setEditedStudent(prev => ({ ...prev, specialization: e.target.value }))}
                            />
                        </label>
                        <label>
                            Year:
                            <input
                                type="text"
                                value={editedStudent.year}
                                onChange={(e) => setEditedStudent(prev => ({ ...prev, year: e.target.value }))}
                            />
                        </label>
                        <label>
                            Semester:
                            <input
                                type="text"
                                value={editedStudent.semester}
                                onChange={(e) => setEditedStudent(prev => ({ ...prev, semester: e.target.value }))}
                            />
                        </label>
                        <label>
                            Section:
                            <input
                                type="text"
                                value={editedStudent.section}
                                onChange={(e) => setEditedStudent(prev => ({ ...prev, section: e.target.value }))}
                            />
                        </label>
                        <button onClick={handleSaveEdit}>Save</button>
                        <button onClick={() => setIsEditModalOpen(false)}>Cancel</button>
                    </div>
                </div>
            )}
        </div>
    );
}

export default Students;
