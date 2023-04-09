const express = require('express');
const getDiscussions = require('../controllers/discussionController');

const discussionRouter = express.Router();

discussionRouter.post('/discussions',getDiscussions)

module.exports = discussionRouter;