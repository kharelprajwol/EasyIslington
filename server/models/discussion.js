const mongoose = require('mongoose');

const commentSchema = new mongoose.Schema({
  body: {
    type: String,
    required: true
  },
  author: {
    type: String,
    required: true
  },
  date: {
    type: String,
    required: true
  }
});

const postSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true
  },
  body: {
    type: String,
    required: true
  },
  author: {
    type: String,
    required: true
  },
  date: {
    type: String,
    required: true
  },
  comments: {
   type: [commentSchema],
   required: true
  }
});

const discussionSchema = new mongoose.Schema({
  specialization: {
    type: String,
    required: true
  },
  posts: {
    type: [postSchema],
    required: true
  }
});

const discussion = mongoose.model('discussions', discussionSchema);

module.exports = discussion;
