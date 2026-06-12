require('dotenv').config();
const express = require('express');
const { BlobServiceClient } = require('@azure/storage-blob');
const multer = require('multer'); // Middleware for handling file uploads
const cors = require('cors');

const app = express();
const port = 3000;

// Middleware
app.use(cors()); // Allow requests from the frontend

// Configure Multer to hold the file in memory temporarily
const upload = multer({ storage: multer.memoryStorage() });

// Azure Configuration
const AZURE_STORAGE_CONNECTION_STRING = process.env.AZURE_CONNECTION_STRING;
const CONTAINER_NAME = "input"; // Ensure this container exists in your Azure Storage

// The Upload Route
app.post('/upload', upload.single('myFile'), async (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).send("No file uploaded.");
        }

        // 1. Connect to the Blob Service
        const blobServiceClient = BlobServiceClient.fromConnectionString(AZURE_STORAGE_CONNECTION_STRING);
        const containerClient = blobServiceClient.getContainerClient(CONTAINER_NAME);

        // 2. Create a unique name for the blob (file)
        const blobName = Date.now() + '-' + req.file.originalname;
        const blockBlobClient = containerClient.getBlockBlobClient(blobName);

        // 3. Upload data to the blob
        console.log(`Uploading ${blobName}...`);
        await blockBlobClient.upload(req.file.buffer, req.file.size);

        res.status(200).send({ message: "File uploaded successfully!", url: blockBlobClient.url });

    } catch (error) {
        console.error(error);
        res.status(500).send(error.message);
    }
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});

process.on('uncaughtException', (err) => {
    console.error('There was an uncaught error:', err);
});

process.on('unhandledRejection', (reason, promise) => {
    console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});