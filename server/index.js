const express = require("express");

const connectToDatabase = require('./controllers/dbController');
const authRouter = require("./routes/authRoutes");
const scheduleRouter = require("./routes/scheduleRoutes");
const discussionRouter = require("./routes/discussionRoutes");
const assesmentScheduleRouter = require("./routes/assesmentScheduleRoutes");
const gradeHubRouter = require("./routes/gradehubRoutes");

const PORT = 3000;
const app = express();

app.use(express.json());
app.use('/api', authRouter,scheduleRouter,discussionRouter,assesmentScheduleRouter,gradeHubRouter);

connectToDatabase();

app.listen(PORT, '0.0.0.0', () => {
  console.log(`server running at port ${PORT}`);
});
