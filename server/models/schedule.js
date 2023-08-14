const mongoose = require('mongoose');

const classSchema = new mongoose.Schema({
  module_title: {
    type: String,
    required: true
  },
  instructor_name: {
    type: String,
    required: true
  },
  block: {
    type: String,
    required: true
  },
  room: {
    type: String,
    required: true
  },
  class_type: {
    type: String,
    required: true
  },
  start_time: {
    type: String,
    required: true,
    validate: {
      validator: function(v) {
        return /^(\d{1,2}:\d{2}\s?(AM|PM)?)$/i.test(v);
      },
      message: props => `${props.value} is not a valid time format!`
    }
  },
  end_time: {
    type: String,
    required: true,
    validate: {
      validator: function(v) {
        return /^(\d{1,2}:\d{2}\s?(AM|PM)?)$/i.test(v);
      },
      message: props => `${props.value} is not a valid time format!`
    }
  },
  hasNotification: {
    type: Boolean,
    default: false,
  },
  notificationTimeBeforeStart: { 
    type: Number,
    default: 15, 
  }
});

const daySchema = new mongoose.Schema({
  day_name: {
    type: String,
    required: true
  },
  classes: {
    type: [classSchema],
    required: true
  }
});

const sectionSchema = new mongoose.Schema({
  section_name: {
    type: String,
    required: true
  },
  days: {
    type: [daySchema],
    required: true
  }
});

const semesterSchema = new mongoose.Schema({
  semester_number: {
    type: String,
    required: true
  },
  sections: {
    type: [sectionSchema],
    required: true
  }
});
  
const yearSchema = new mongoose.Schema({
  year_number: {
    type: String,
    required: true
  },
  semesters: {
    type: [semesterSchema],
    required: true
  }
});
  
const scheduleSchema = new mongoose.Schema({
  specialization_name: {
    type: String,
    required: true
  },
  years: {
    type: [yearSchema],
    required: true
  }
});

const Schedule = mongoose.model('schedules', scheduleSchema);
module.exports = Schedule;
