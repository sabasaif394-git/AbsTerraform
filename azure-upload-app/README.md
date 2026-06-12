# Azure Blob Storage File Uploader

A simple web application to upload files directly to Azure Blob Storage using a Node.js (Express) backend and a vanilla HTML/JS frontend.

## Prerequisites
* [Node.js](https://nodejs.org/) installed.
* An active **Azure Storage Account**.
* A container named `uploads` created in your Storage Account.

## Setup

1.  **Install Dependencies**
    ```bash
    npm install
    ```

2.  **Configure Environment**
    Create a file named `.env` in the root directory and add your Azure Connection String:
    ```env
    AZURE_CONNECTION_STRING=DefaultEndpointsProtocol=https;AccountName=YOUR_ACCOUNT_NAME;AccountKey=YOUR_KEY;EndpointSuffix=core.windows.net
    ```
    *(Note: Ensure there are no spaces around the `=` sign)*

3.  **Start the Server**
    ```bash
    node server.js
    ```

## Usage
1.  Ensure the server is running (default: `http://localhost:3000`).
2.  Open `index.html` in your web browser.
3.  Select a file and click **Upload**.
4.  Check the browser console or the Azure Portal to verify the upload.

## Project Structure
```text
/azure-upload-app
├── .env                 # API Keys (Do not commit this!)
├── .gitignore           # Ignores node_modules and .env
├── index.html           # Frontend UI
├── package.json         # Project dependencies
├── server.js            # Backend Logic
└── README.md            # Project documentation