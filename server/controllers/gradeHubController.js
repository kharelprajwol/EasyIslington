const { StudentMarks } = require('../models/gradehub');

// Get years by studentId using POST request
const getMarksById = async (req, res) => {
  try {
    const studentId = req.body.studentId;
    const student = await StudentMarks.findOne({ studentId });

    if (!student) {
      return res.status(404).json({ message: 'Student not found' });
    }

    res.json(student.years);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error });
  }
};

module.exports = getMarksById;
