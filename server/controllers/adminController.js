const bcrypt = require('bcrypt');
const Admin = require('../models/admin');
const Student = require('../models/student');
const Discussion = require('../models/discussion');

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
exports.resetAdminPassword = async (req, res) => {
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
    console.log(id);
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

// Reset Student Password
exports.resetStudentPassword = async (req, res) => {
    try {
        const {studentId} = req.params; // get student ID from params
        console.log("Student ID:", studentId);

        const { newPassword } = req.body; // get new password from request body

        // Find the student by their ID
        const student = await Student.findById(studentId);

        if (!student) {
            return res.status(404).json({ success: false, message: 'Student not found!' });
        }

        // Hash the new password
        const hashedPassword = await bcrypt.hash(newPassword, SALT_ROUNDS);

        // Update the student's password
        student.password = hashedPassword;

        // Save the updated student information
        await student.save();

        // Send success response
        res.status(200).json({
            success: true,
            data: student,
            message: 'Student password reset successfully.'
        });

    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Server error. Please try again.',
            error: error.message
        });
    }
};

exports.getTotalStudents = async (req, res) => {
    try {
        const studentCount = await Student.countDocuments(); // Uses the countDocuments function from mongoose

        res.status(200).json({
            success: true,
            count: studentCount
        });

    } catch (error) {
        console.error("Error fetching total student count:", error.message);
        res.status(500).json({
            success: false,
            message: "Server error"
        });
    }
};


exports.getTotalPostCount = async (req, res) => {
    try {
        const discussions = await Discussion.find();
        let totalCount = 0;

        discussions.forEach(discussion => {
            // Check if the discussion has posts
            if (discussion.posts && discussion.posts.length > 0) {
                totalCount += discussion.posts.length;
            }
        });

        res.status(200).json({ count: totalCount });
    } catch (error) {
        console.error(error); // Log the error for debugging
        res.status(500).json({ message: 'Failed to retrieve post count', error });
    }
};

// Change Admin Password without verifying old password
exports.changeAdminPassword = async (req, res) => {
    try {
        const { adminId } = req.params; // Get the admin's ID from the request parameters
        const { newPassword } = req.body; // Get the new password from the request body
        
        if (!newPassword || newPassword.trim().length === 0) {
            return res.status(400).json({
                success: false,
                message: 'New password is missing or empty.'
            });
        }

        console.log(`Changing password for adminId: ${adminId}`);

        // Hash the new password
        const hashedPassword = await bcrypt.hash(newPassword, SALT_ROUNDS);

        // Find the admin by their ID and update their password
        const admin = await Admin.findByIdAndUpdate(adminId, { password: hashedPassword }, { new: true });

        if (!admin) {
            return res.status(404).json({
                success: false,
                message: 'Admin not found.'
            });
        }

        return res.status(200).json({
            success: true,
            message: 'Admin password changed successfully.'
        });
    } catch (error) {
        if (error.kind === 'ObjectId') { // This checks for invalid MongoDB ObjectID format
            return res.status(400).json({
                success: false,
                message: 'Invalid admin ID format.',
                error: error.message
            });
        }

        console.error('Error in changeAdminPassword:', error);
        return res.status(500).json({
            success: false,
            message: 'Server error. Please try again.',
            error: error.message
        });
    }
};











