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
router.put('/reset-password/:adminId', adminController.resetPassword);
router.delete('/delete-admin/:adminId', adminController.deleteAdmin);

router.get('/students', adminController.getStudents);
router.put('/edit-student/:id', adminController.updateStudent);

module.exports = router;
