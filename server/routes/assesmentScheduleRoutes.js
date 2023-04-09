const express = require('express');
const getAssesmentSchedule = require('../controllers/assesmentScheduleController');

const assesmentScheduleRouter = express.Router();

assesmentScheduleRouter.post('/assesmentschedule',getAssesmentSchedule)

module.exports = assesmentScheduleRouter;