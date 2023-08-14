const express = require('express');
const getSchedule = require('../controllers/scheduleController');

const scheduleRouter = express.Router();

scheduleRouter.post('/schedules',getSchedule)

module.exports = scheduleRouter;