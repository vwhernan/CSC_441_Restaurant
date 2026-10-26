# MATSURI – Database Setup and API Documentation

**Course:** CSC 441  
**Project:** MATSURI Restaurant Website  
**Backend:** Node.js / Express  
**Databases:** MySQL and MongoDB Atlas

## 1. Overview

The MATSURI restaurant website uses MySQL and MongoDB Atlas to store and manage its data. MySQL handles the restaurant menu, including dish names, prices, descriptions, categories, and ingredients. MongoDB Atlas stores customer reviews.

The backend uses Node.js and Express to connect both databases to the website. Instead of having the frontend communicate directly with the databases, JavaScript sends requests to the backend API endpoints. The backend retrieves or stores the requested information and returns a response.

This setup keeps database credentials out of the frontend code and allows the menu and review sections to be developed separately from the database connections.

## 2. Project Files

The main files used for database integration are:

| File | Purpose |
|---|---|
| `backend/server.js` | Runs the Express server and handles API requests |
| `backend/mysql.js` | Creates the MySQL connection pool |
| `backend/package.json` | Lists the backend dependencies |
| `backend/.env.example` | Provides a template for database configuration |
| `matsuri_database.sql` | Contains the MySQL database structure and menu records |
| `integration-test.html` | Tests the menu and review API connections |

The actual `.env` file is excluded from Git because it contains database credentials.

## 3. Software Requirements

Before running the backend, install the following:

- Node.js and npm
- MySQL Server
- MySQL Workbench (recommended)
- Git
- A code editor such as Visual Studio Code

Access to the MongoDB Atlas database is also required to use the customer review endpoints.

## 4. Backend Setup

After cloning the repository, open a terminal and navigate to the backend folder:

```powershell
cd backend
```

Install the required Node.js packages:

```powershell
npm install
```

The dependencies are listed in `package.json` and include Express, MySQL2, the MongoDB driver, and dotenv.

The `node_modules` folder is generated during installation and should not be committed to GitHub.

## 5. MySQL Database Setup

