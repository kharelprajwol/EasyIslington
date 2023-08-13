const Discussion = require('../models/discussion');

// Create a new post for a specific specialization
exports.createPost = async (req, res) => {
  try {
    const { specialization, title, content, author } = req.body;

    let discussion = await Discussion.findOne({ specialization });

    if (!discussion) {
      // If discussion doesn't exist, create a new one
      discussion = new Discussion({
        specialization,
        posts: [],
      });
    }

    const newPost = {
      title,
      content,
      author,
    };

    discussion.posts.push(newPost);
    await discussion.save();

    res.status(201).json(newPost);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error' });
  }
};

// Add a comment to a post
exports.addComment = async (req, res) => {
  try {
    const { postId, text, author } = req.body;

    const discussion = await Discussion.findOne({ 'posts._id': postId });

    if (!discussion) {
      return res.status(404).json({ message: 'Post not found' });
    }

    const newComment = {
      text,
      author,
    };

    const post = discussion.posts.id(postId);
    post.comments.push(newComment);
    await discussion.save();

    res.status(201).json(newComment);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error' });
  }
};

// Get all posts with details and comments for a specific specialization
exports.getPosts = async (req, res) => {
  try {
    const { specialization } = req.params;

    const discussion = await Discussion.findOne({ specialization });

    if (!discussion) {
      return res.status(404).json({ message: 'No post yet!' });
    }

    res.status(200).json(discussion);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error' });
  }
};







