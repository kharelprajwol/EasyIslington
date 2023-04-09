const Discussion = require('../models/discussion');

const getDiscussions = async (req, res) => {
  const { specialization } = req.body;
  const specializationObj = await Discussion.findOne({ specialization });
  const { posts } = specializationObj;
  res.send(posts);
};

module.exports = getDiscussions;
