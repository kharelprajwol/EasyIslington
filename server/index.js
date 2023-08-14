const express = require("express");
const cors = require('cors');


const connectToDatabase = require('./controllers/dbController');
const authRouter = require("./routes/authRoutes");
const scheduleRouter = require("./routes/scheduleRoutes");
const discussionRouter = require("./routes/discussionRoutes");
const adminRouter = require("./routes/adminRoutes");
const gradeHubRouter = require("./routes/gradehubRoutes");

const PORT = 3000;
const app = express();

app.use(cors());
app.use(express.json());
app.use('/api', authRouter,scheduleRouter,discussionRouter,gradeHubRouter);
app.use('/admin', adminRouter);

connectToDatabase();

app.listen(PORT, '0.0.0.0', () => {
  console.log(`server running at port ${PORT}`);
});
