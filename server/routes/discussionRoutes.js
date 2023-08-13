const express = require('express');
const {
  createPost,
  addComment,
  getPosts
} = require('../controllers/discussionController');

const discussionRouter = express.Router();

// Create a new post
discussionRouter.post('/create-post', createPost);

// Add a comment to a post
discussionRouter.post('/add-comment', addComment);

// Get all posts with details and comments for a specific specialization
discussionRouter.get('/get-posts/:specialization', getPosts);

module.exports = discussionRouter;
