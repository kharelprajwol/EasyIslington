const Schedule = require('../models/schedule');

const getSchedule = async (req, res) => {
  try {
    const { specialization, year, semester, section } = req.body;

    // Find the specialization object in the database
    const specializationObj = await Schedule.findOne({ specialization_name: specialization });
    if (!specializationObj) {
      return res.status(404).json({ error: `Specialization ${specialization} not found` });
    }

    // Find the year object in the specialization
    const yearObj = specializationObj.years.find(y => y.year_number === year);
    if (!yearObj) {
      return res.status(404).json({ error: `Year ${year} not found for specialization ${specialization}` });
    }

    // Find the semester object in the year
    const semesterObj = yearObj.semesters.find(s => s.semester_number === semester);
    if (!semesterObj) {
      return res.status(404).json({ error: `Semester ${semester} not found for year ${year} in specialization ${specialization}` });
    }

    // Find the section object in the semester
    const sectionObj = semesterObj.sections.find(s => s.section_name === section);
    if (!sectionObj) {
      return res.status(404).json({ error: `Section ${section} not found for semester ${semester} in year ${year} of specialization ${specialization}` });
    }

    res.send(sectionObj['days']);
  } catch (e) {
    console.log(e);
    res.status(500).json({ error: e.message });
  }
};

module.exports = getSchedule;
