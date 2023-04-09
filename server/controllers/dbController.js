const mongoose = require('mongoose');
require('dotenv').config(); // Importing dotenv to load environment variables from .env file

// Reusable function to connect to MongoDB database
const connectToDatabase = async () => {
    try {
        // Connecting to the MongoDB database using the URI from the .env file
        await mongoose.connect(process.env.DB_URI, { 
            useNewUrlParser: true, 
            useUnifiedTopology: true 
        });
        console.log('Connected to MongoDB');
    } catch (error) {
        // Logging the error messsage if there is an error connecting to the database
        console.error(`MongoDB connection error: ${error}`);
    }
};

module.exports = connectToDatabase;
