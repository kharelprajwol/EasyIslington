const express = require('express');
const getMarksById = require('../controllers/gradeHubController');

const gradeHubRouter = express.Router();

gradeHubRouter.post('/marks', getMarksById);

module.exports = gradeHubRouter;
