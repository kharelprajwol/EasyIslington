const express = require("express");
const authController = require('../controllers/authController');

const authRouter = express.Router();

authRouter.post("/signup",authController.addStudent);
authRouter.post("/signin",authController.authenticateStudent);
authRouter.put("/update-student/:studentId",authController.updateStudent);
authRouter.post("/check-old-password",authController.checkOldPassword);
authRouter.post("/update-password",authController.updatePassword);
authRouter.post("/check-email",authController.checkEmailInDatabase);


module.exports = authRouter;
