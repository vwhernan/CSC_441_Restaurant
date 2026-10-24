/* This is the Node.js backend server. It connects the restaurant website to MongoDB Atlas
so customer  reviews stored in the database can appear on the webpage. */

// Load the MongoDB connection string and other variables from .env
require('dotenv').config();

const express = require('express');
const { MongoClient } = require("mongodb");

const app = express();

// Allow the server to access the website's HTML, CSS, and JS files
const path = require("path");
app.use(express.static(path.join(__dirname, "..")));

const port = process.env.PORT || 3000;

const client = new MongoClient(process.env.MONGODB_URI);

app.use(express.json());

// Retrieve all customer reviews
app.get('/api/reviews', async (req, res) => {
    try {

        const database = client.db("restaurant");
        const reviews = database.collection("reviews");
        const results = await reviews.find({}).toArray();

        res.json(results);
    }
    catch (error) {
        console.error("Error retrieving reviews:", error);
        res.status(500).json({ error: "Unable to retrieve reviews" });
    }
});

// Start the server after connecting to MongoDB
async function startServer() {
    try {
        // Connect to the MongoDB Atlas cluster
        await client.connect();
        console.log("Connected to MongoDB Atlas");

        app.listen(port, () => {
            console.log(`Server running at http://localhost:${port}`);
        });

    } catch (error) {
        console.error("MongoDB connection failed", error);
        process.exit(1);
    }
}

startServer();

 // Save a new customer review to MongoDB
app.post('/api/reviews', async (req, res) => {
    try {
        const { customer_name, rating, comment } = req.body;

        // Check that all required fields contain valid information
        if (typeof customer_name !== "string" ||
            !customer_name.trim() ||
            typeof comment !== "string" ||
            !comment.trim() ||
            !Number.isInteger(rating) ||
            rating < 1 || rating > 5) {

            return res.status(400).json({
                error: "Enter a name, comment, and rating between 1 and 5"
            });
        }

        // Select the database and reviews collection
        const database = client.db("restaurant");
        const reviews = database.collection("reviews");

        const newReview = {
            customer_name: customer_name.trim(),
            rating: rating,
            comment: comment.trim(),
            created_at: new Date()
        };

        // Save the review to MongoDB
        const result = await reviews.insertOne(newReview);

        res.status(201).json({
            message: "Review submitted successfully",
            review_id: result.insertedId
        });

    } catch (error) {
        console.error("Error saving review:", error);
        res.status(500).json({
            error: "Unable to save review"
        });
    }
});
