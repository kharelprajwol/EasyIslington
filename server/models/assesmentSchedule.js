const mongoose = require('mongoose');

const assessmentSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  percentage_weight: {
    type: String,
    required: true
  },
  coursework_submission_deadline: {
    type: Date,
    required: true
  },
  exam_date: {
    type: Date,
    required: true
  }
});

const moduleSchema = new mongoose.Schema({
  module_title: {
    type: String,
    required: true
  },
  assessments: {
    type: [assessmentSchema],
    required: true
  }
});

const yearSchema = new mongoose.Schema({
  year_number: {
    type: String,
    required: true
  },
  modules: {
    type: [moduleSchema],
    required: true
  }
});

const specializationSchema = new mongoose.Schema({
  specialization_name: {
    type: String,
    required: true
  },
  years: {
    type: [yearSchema],
    required: true
  }
});

const assesmentSchedule = mongoose.model('assesment_schedules', specializationSchema);
module.exports = assesmentSchedule;
