const mongoose = require('mongoose');

const adminSchema = mongoose.Schema({
    fullName: {
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
    }
});

const Admin = mongoose.model("admins", adminSchema);
module.exports = Admin;
