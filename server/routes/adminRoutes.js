const express = require('express');
const router = express.Router();
const adminController = require('../controllers/adminController'); // Update with your path

// Middleware to check admin authentication
// This is just a placeholder. You need to implement this based on your requirements
// const checkAdminAuth = require('./path_to_your_middleware');

router.get('/admins', adminController.getAdmins);
router.post('/login-admin', adminController.loginAdmin);
router.post('/add-admin', adminController.addAdmin);
router.put('/edit-admin/:adminId', adminController.editAdmin);
router.put('/reset-admin-password/:adminId', adminController.resetAdminPassword);
router.delete('/delete-admin/:adminId', adminController.deleteAdmin);
router.post('/change-admin-password/:adminId', adminController.changeAdminPassword);

router.get('/students', adminController.getStudents);
router.put('/edit-student/:id', adminController.updateStudent);
router.put('/reset-student-password/:studentId', adminController.resetStudentPassword);
router.get('/total-students', adminController.getTotalStudents);
router.get('/total-posts', adminController.getTotalPostCount);

module.exports = router;
