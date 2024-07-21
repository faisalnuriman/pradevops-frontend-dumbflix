
# Dumbflix Frontend Deployment Guide

## Introduction

Welcome to the deployment guide for the Dumbflix frontend application. This document will guide you through the steps required to set up and deploy the frontend on your local machine.

## Prerequisites

Before you begin, ensure you have the following installed on your machine:

- **Node.js**: Version 10.x or below. You can download it from [Node.js official website](https://nodejs.org/).

## Step-by-Step Deployment

### 1. Clone the Repository

Start by cloning the repository to your local machine. Open your terminal and run the following command:

```bash
git clone <repository_url>
Replace <repository_url> with the URL of your Dumbflix frontend repository.

2. Install Node.js
Ensure you have Node.js version 10.x or below installed. You can verify your Node.js version by running:

bash
Copy code
node -v
If you do not have the correct version, you can download and install it from Node.js official website.

3. Install Dependencies
Navigate to the project directory and install the required dependencies:

bash
Copy code
cd dumbflix-frontend
npm install
4. Configure API URL
Update the URL for the Dumbflix backend in the configuration file:

Open src/config/api.js in your preferred text editor.
Locate the line where the backend URL is defined.
Replace the existing URL with the URL of your Dumbflix backend.
Example:

baseURL: 'https://api.cocofuture.com/api/v1'  ## change to backend url
Save the file after making the changes.

5. Deploy the Frontend
Start the frontend server on port 3000 by running:

bash
Copy code
npm start
This will launch the Dumbflix frontend application, and you can access it by navigating to http://localhost:3000 in your web browser.

Conclusion
You have successfully deployed the Dumbflix frontend application. If you encounter any issues or have any questions, feel free to reach out for support.

Happy streaming!