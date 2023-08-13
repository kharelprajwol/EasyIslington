import React, { useState } from 'react';
import './Programmes.css';

function Programmes() {
    const [specializations, setSpecializations] = useState([
        { id: 1, name: 'Science' },
        { id: 2, name: 'Arts' },
        // Add more specializations
    ]);
    const [selectedSpecialization, setSelectedSpecialization] = useState(null);
    const [years, setYears] = useState([]);
    const [selectedYear, setSelectedYear] = useState(null);
    const [semesters, setSemesters] = useState([]);
    const [selectedSemester, setSelectedSemester] = useState(null);
    const [sections, setSections] = useState([]);

    const handleSpecializationClick = (specialization) => {
        setSelectedSpecialization(specialization);
        setSelectedYear(null);
        setSelectedSemester(null);
        // Simulate fetching years for the selected specialization
        setYears([
            { id: 1, year: 'First Year' },
            { id: 2, year: 'Second Year' },
            // Add more years
        ]);
        setSemesters([]);
        setSections([]);
    };

    const handleYearClick = (year) => {
        setSelectedYear(year);
        setSelectedSemester(null);
        // Simulate fetching semesters for the selected year
        setSemesters([
            { id: 1, semester: 'Semester 1' },
            { id: 2, semester: 'Semester 2' },
            // Add more semesters
        ]);
        setSections([]);
    };

    const handleSemesterClick = (semester) => {
        setSelectedSemester(semester);
        // Simulate fetching sections for the selected semester
        setSections([
            { id: 1, section: 'Section A' },
            { id: 2, section: 'Section B' },
            // Add more sections
        ]);
    };

    const handleAddSection = () => {
        const newSectionId = sections.length + 1;
        const newSection = { id: newSectionId, section: `Section ${String.fromCharCode(65 + newSectionId)}` };
        setSections([...sections, newSection]);
    };

    const handleDeleteSection = (sectionId) => {
        const updatedSections = sections.filter(section => section.id !== sectionId);
        setSections(updatedSections);
    };

    return (
        <div>
            <h1>Programmes</h1>
            <div className="specializations">
                {specializations.map(specialization => (
                    <button
                        key={specialization.id}
                        className={selectedSpecialization === specialization ? 'selected' : ''}
                        onClick={() => handleSpecializationClick(specialization)}
                    >
                        {specialization.name}
                    </button>
                ))}
            </div>

            {selectedSpecialization && (
                <div className="years">
                    {years.map(year => (
                        <button
                            key={year.id}
                            className={selectedYear === year ? 'selected' : ''}
                            onClick={() => handleYearClick(year)}
                        >
                            {year.year}
                        </button>
                    ))}
                </div>
            )}

            {selectedYear && (
                <div className="semesters">
                    {semesters.map(semester => (
                        <button
                            key={semester.id}
                            className={selectedSemester === semester ? 'selected' : ''}
                            onClick={() => handleSemesterClick(semester)}
                        >
                            {semester.semester}
                        </button>
                    ))}
                </div>
            )}

            {selectedSemester && (
                <div>
                    <h2>Sections</h2>
                    <button onClick={handleAddSection}>Add Section</button>
                    <ul>
                        {sections.map(section => (
                            <li key={section.id}>
                                {section.section}
                                <button onClick={() => handleDeleteSection(section.id)}>Delete</button>
                            </li>
                        ))}
                    </ul>
                </div>
            )}
        </div>
    );
}

export default Programmes;
