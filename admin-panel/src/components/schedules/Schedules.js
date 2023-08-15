import React, { useState } from 'react';
import './Schedules.css';

function Schedules() {
  const [selectedFile, setSelectedFile] = useState(null);

  // Function to handle adding schedules from JSON
  const handleAddSchedule = async (e) => {
    e.preventDefault();
    const file = e.target.files[0];

    if (file) {
      const data = await readFileAsJSON(file);
      setSelectedFile(data);
      // TODO: Add code to send this data to the database
    }
  };

  const readFileAsJSON = (file) => {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.onload = (event) => {
        try {
          const json = JSON.parse(event.target.result);
          resolve(json);
        } catch (error) {
          reject(new Error("Failed to parse JSON."));
        }
      };
      reader.onerror = (error) => reject(error);
      reader.readAsText(file);
    });
  };

  const handleDeleteSchedule = () => {
    // TODO: Add code to delete the schedule from the database
  };

  return (
    <div>
      {/* Add Schedule from JSON form */}
      <div className="add-schedule-form">
        <label>
          <input type="file" accept=".json" onChange={handleAddSchedule} style={{ display: 'none' }} />
          <button type="button" onClick={() => document.querySelector('.add-schedule-form input').click()}>Add via JSON</button>
        </label>
        <button type="button" onClick={handleDeleteSchedule}>Delete</button>
      </div>
    </div>
  );
}

export default Schedules;
