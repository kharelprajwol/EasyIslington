const express = require("express");
const authController = require('../controllers/authController');


const authRouter = express.Router();

authRouter.post("/signup",authController.addStudent);
authRouter.post("/signin",authController.authenticateStudent); 

module.exports = authRouter;
