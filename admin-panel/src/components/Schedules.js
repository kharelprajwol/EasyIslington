import React, { useState } from 'react';
import './Schedules.css';
import pdfjs from 'pdfjs-dist';

function Schedules() {
  const [schedules, setSchedules] = useState([]);

  // Function to handle adding schedules from PDF
  const handleAddSchedule = async (e) => {
    e.preventDefault();
    const file = e.target.files[0];

    if (file) {
      const data = await readFileAsArrayBuffer(file);
      const parsedData = await parsePDFData(data);
      setSchedules([...schedules, parsedData]);
    }
  };

  const readFileAsArrayBuffer = (file) => {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.onload = (event) => resolve(event.target.result);
      reader.onerror = (error) => reject(error);
      reader.readAsArrayBuffer(file);
    });
  };

  const parsePDFData = async (data) => {
    const loadingTask = pdfjs.getDocument({ data });

    const pdfDocument = await loadingTask.promise;
    const numPages = pdfDocument.numPages;

    let text = '';

    for (let pageNumber = 1; pageNumber <= numPages; pageNumber++) {
      const page = await pdfDocument.getPage(pageNumber);
      const pageText = await page.getTextContent();
      pageText.items.forEach((item) => {
        text += item.str + ' ';
      });
    }

    return text.trim(); // Return the extracted text
  };

  return (
    <div>
      {/* Add Schedule from PDF form */}
      <form onSubmit={handleAddSchedule} className="add-schedule-form">
        <input type="file" accept=".pdf" />
        <button type="submit">Add Schedule from PDF</button>
      </form>

      {/* Display schedules */}
      <div className="schedule-list">
        {/* Mapping and displaying schedules */}
        {schedules.map((schedule, index) => (
          <div key={index} className="schedule-item">
            <p>{schedule}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

export default Schedules;
