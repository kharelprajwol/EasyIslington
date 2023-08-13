const mongoose = require('mongoose');

const commentSchema = new mongoose.Schema({
  text: String,
  author: String,
  createdAt: { type: Date, default: Date.now }
});

const postSchema = new mongoose.Schema({
  title: String,
  content: String,
  author: String,
  createdAt: { type: Date, default: Date.now },
  comments: [commentSchema] // Embed comments directly within the post
});

const discussionSchema = new mongoose.Schema({
  specialization: String,
  posts: [postSchema] // Embed posts directly within the specialization
});

const Discussion = mongoose.model('discussions', discussionSchema);

module.exports = Discussion;
