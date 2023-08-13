const mongoose = require('mongoose');

const studentSchema = mongoose.Schema({
    firstName: {
        required: true,
        type: String,
        trim: true,
    },
    lastName: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        unique: true
    },
    username: {   
        required: true,
        type: String,
        trim: true,
        unique: true 
    },
    password: {
        required: true,
        type: String,
    },
    specialization: {
        required: true,
        type: String,
    },
    year: {
        required: true,
        type: String
    },
    semester: {
        required: true,
        type: String
    },
    group: {    // Changed from 'section' to 'group'
        required: true,
        type: String
    }
})

const Student = mongoose.model("students", studentSchema);
module.exports = Student;
