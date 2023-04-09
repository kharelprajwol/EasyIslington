const express = require('express');
const getSchedule = require('../controllers/scheduleController');

const scheduleRouter = express.Router();

scheduleRouter.post('/schedule',getSchedule)

module.exports = scheduleRouter;