const bcrypt = require('bcrypt');
const Admin = require('../models/admin');
const Student = require('../models/student');

const SALT_ROUNDS = 10;

const jwt = require('jsonwebtoken'); // Assuming you're using JWT for authentication

// Login Admin
exports.loginAdmin = async (req, res) => {
    try {
        const { username, password } = req.body;

        // Check for admin with given username
        const admin = await Admin.findOne({ username });
        if (!admin) {
            return res.status(400).json({
                success: false,
                message: 'Invalid username or password.'
            });
        }

        // Check if the password is correct
        const isPasswordValid = await bcrypt.compare(password, admin.password);
        if (!isPasswordValid) {
            return res.status(400).json({
                success: false,
                message: 'Invalid username or password.'
            });
        }

        // Generate a token for the logged-in admin (Optional: if you're using JWT authentication)
        const token = jwt.sign({ 
            id: admin._id, 
            username: admin.username 
        }, 'YOUR_SECRET_KEY', { expiresIn: '1h' }); // Replace 'YOUR_SECRET_KEY' with your secret key

        res.status(200).json({
            success: true,
            data: { token, admin }, // Send token and admin details
            message: 'Logged in successfully.'
        });

    } catch (error) {
        console.error(error);
        res.status(500).json({
            success: false,
            message: 'Server error. Please try again.'
        });
    }
};


// Add Admin
exports.addAdmin = async (req, res) => {
    try {
        const { fullName, email, username, password } = req.body;

        // Check if the username already exists
        let existingAdmin = await Admin.findOne({ username });
        if (existingAdmin) {
            return res.status(400).json({
                success: false,
                message: 'Username already exists.'
            });
        }

        // Hash password
        const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS);

        const admin = new Admin({
            fullName,
            email,
            username,
            password: hashedPassword
        });

        await admin.save();

        res.status(201).json({
            success: true,
            data: admin,
            message: 'Admin added successfully.'
        });

    } catch (error) {
        console.error(error);
        res.status(500).json({
            success: false,
            message: 'Server error. Please try again.'
        });
    }
};


// Edit Admin
exports.editAdmin = async (req, res) => {
    try {
        const { adminId } = req.params;
        const update = req.body;

        const admin = await Admin.findByIdAndUpdate(adminId, update, {
            new: true
        });

        res.status(200).json({
            success: true,
            data: admin,
            message: 'Admin updated successfully.'
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Server error. Please try again.'
        });
    }
};

// Reset Password
exports.resetPassword = async (req, res) => {
    try {
        const { adminId } = req.params;
        const { newPassword } = req.body;

        // Hash password
        const hashedPassword = await bcrypt.hash(newPassword, SALT_ROUNDS);

        const admin = await Admin.findByIdAndUpdate(adminId, {
            password: hashedPassword
        }, {
            new: true
        });

        res.status(200).json({
            success: true,
            data: admin,
            message: 'Password reset successfully.'
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Server error. Please try again.'
        });
    }
};

// Delete Admin
exports.deleteAdmin = async (req, res) => {
    try {
        const { adminId } = req.params;

        await Admin.findByIdAndRemove(adminId);

        res.status(200).json({
            success: true,
            message: 'Admin deleted successfully.'
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Server error. Please try again.'
        });
    }
};

// Get All Admins
exports.getAdmins = async (req, res) => {
   
    try {
        const admins = await Admin.find({}); // Fetch all admins from the database

        res.status(200).json({
            success: true,
            data: admins
        });

    } catch (error) {
        console.error(error);
        res.status(500).json({
            success: false,
            message: 'Server error. Please try again.'
        });
    }
};

exports.getStudents = async (req, res) => {
    try {
        const students = await Student.find({}); // Fetch all students from the database

        res.status(200).json({
            success: true,
            data: students
        });

    } catch (error) {
        console.error(error);
        res.status(500).json({
            success: false,
            message: 'Server error. Please try again.'
        });
    }
};

exports.updateStudent = async (req, res) => {
    const { id } = req.params;
    const { firstName, lastName, specialization, year, semester, section } = req.body;

    try {
        const updatedStudent = await Student.findByIdAndUpdate(
            id,
            { firstName, lastName, specialization, year, semester, section },
            { new: true } // This option ensures the function returns the updated version of the document.
        );

        if (!updatedStudent) {
            return res.status(404).json({ success: false, message: 'Student not found!' });
        }

        res.status(200).json({ success: true, student: updatedStudent });

    } catch (error) {
        res.status(500).json({ success: false, message: 'Server error', error: error.message });
    }
};

