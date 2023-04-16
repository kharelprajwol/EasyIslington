const mongoose = require('mongoose');

const AssessmentSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  weight: {
    type: Number,
    required: true,
  },
  mark: {
    type: Number,
    required: true,
  },
});

const ModuleSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  credit: {
    type: Number,
    required: true,
  },
  assessments: [AssessmentSchema],
});

const YearSchema = new mongoose.Schema({
  year: {
    type: String,
    required: true,
  },
  weight: {
    type: Number,
    required: true,
  },
  modules: [ModuleSchema],
});

const StudentMarksSchema = new mongoose.Schema({
  studentId: {
    type: String,
    required: true,
    unique: true,
  },
  years: [YearSchema],
});

const StudentMarks = mongoose.model('student_marks', StudentMarksSchema);

module.exports = {
  StudentMarks,
};
