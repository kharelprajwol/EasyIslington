const AssesmentSchedule = require('../models/assesmentSchedule');

const getAssesmentSchedule = async (req, res) => {
  try {
    const { specialization, year } = req.body;
    console.log(req.body);
    console.log(specialization);

    // Find the specialization object in the database
    const specializationObj = await AssesmentSchedule.findOne({ specialization_name: specialization });
    if (!specializationObj) {
      return res.status(404).json({ error: `Specialization ${specialization} not found` });
    }

    // Find the year object in the specialization
    const yearObj = specializationObj.years.find(y => y.year_number === year);
    if (!yearObj) {
      return res.status(404).json({ error: `Year ${year} not found for specialization ${specialization}` });
    }

    res.send(yearObj['modules']);
  } catch (e) {
    console.log(e);
    res.status(500).json({ error: e.message });
  }
};

module.exports = getAssesmentSchedule;
