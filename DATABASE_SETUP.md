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

### Database Structure

The MySQL database is named `matsuri` and contains four tables.

| Table | Description |
|---|---|
| `dishes` | Stores dish names, descriptions, prices, and category IDs |
| `categories` | Stores the menu categories |
| `ingredients` | Stores individual ingredients |
| `dish_ingredients` | Connects dishes to their ingredients |

Each dish belongs to one category, while a category can contain multiple dishes. Dishes and ingredients have a many-to-many relationship, which is handled through the `dish_ingredients` table.

### Importing the Database

The repository includes `matsuri_database.sql`, which contains the database structure and records.

To import the database using MySQL Workbench:

1. Open MySQL Workbench and connect to your local MySQL server.
2. Select **Server → Data Import**.
3. Choose **Import from Self-Contained File**.
4. Browse to `matsuri_database.sql` in the project folder.
5. Review the import settings and confirm the file will create and populate the `matsuri` database.
6. Click **Start Import**.

**Important:** The SQL file contains database creation and table statements. Do not import it over an existing `matsuri` database containing data you want to keep.

After importing, run the following query:

```sql
SELECT COUNT(*) AS total_dishes
FROM matsuri.dishes;
```

The expected result is 45 dishes.

The original database contains 8 categories, 103 ingredients, and 144 dish-to-ingredient associations.

### MySQL Connection Settings

The backend reads its MySQL connection settings from environment variables. These are configured in `backend/mysql.js`.

The connection uses a pool, allowing the server to reuse database connections when handling requests.

The default MySQL port is `3306`.

## 6. MongoDB Atlas Setup

MongoDB Atlas is used for customer reviews.

The current database configuration is:

- Database: `restaurant`
- Collection: `reviews`

The backend connects to MongoDB Atlas using a connection string stored in the `.env` file.

To use the review endpoints, team members need valid MongoDB credentials and network access to the cluster. These details should be coordinated with the database developer.

Do not include MongoDB connection strings containing credentials in source code or GitHub commits.

## 7. Environment Variables

Inside the `backend` folder, copy `.env.example` and rename the copy to `.env`.

The configuration should follow this format:

```dotenv
MYSQL_HOST=localhost
MYSQL_USER=your_mysql_username
MYSQL_PASSWORD=your_mysql_password
MYSQL_DATABASE=matsuri
MYSQL_PORT=3306

MONGODB_URI=your_mongodb_connection_string

PORT=3000
```

Replace the placeholder values with the appropriate local MySQL credentials and MongoDB Atlas connection string.

The `.env` file is ignored by Git and should remain on the developer's computer. Only `.env.example`, which contains placeholder values, should be shared.

## 8. Running the Backend

From the `backend` folder, start the server:

```powershell
node server.js
```

When the server starts successfully, the terminal should display messages similar to:

```text
Connected to MongoDB Atlas
Server running at http://localhost:3000
```

The website can then be accessed through the local server.

The backend also serves the website's HTML, CSS, and JavaScript files, so a separate frontend server is not required for local testing.

## 9. API Endpoints

The backend currently provides three API operations.

| Method | Endpoint | Description |
|---|---|---|
| GET | `/api/menu` | Retrieves menu information from MySQL |
| GET | `/api/reviews` | Retrieves customer reviews from MongoDB |
| POST | `/api/reviews` | Submits a customer review to MongoDB |

### GET /api/menu

**URL:** `http://localhost:3000/api/menu`

This endpoint retrieves the menu from MySQL using SQL JOIN statements. The query combines the dishes, categories, and ingredients tables.

The backend then groups the ingredients under their corresponding dishes before returning the results as JSON.

Example response:

```json
[
  {
    "dish_id": 4,
    "dish_name": "Edamame",
    "description": "Steamed soybeans, flaky sea salt.",
    "price": "6.00",
    "category": "LITTLE BEGINNINGS",
    "ingredients": [
      "sea salt",
      "soybeans"
    ]
  }
]
```

The endpoint currently returns 45 dishes.

The frontend can use this data to display menu items without storing the menu information directly in HTML.

### GET /api/reviews

**URL:** `http://localhost:3000/api/reviews`

This endpoint retrieves customer reviews from the MongoDB Atlas `reviews` collection and returns them as JSON.

The endpoint has been tested successfully with three stored reviews.

### POST /api/reviews

**URL:** `http://localhost:3000/api/reviews`

This endpoint allows customers to submit reviews, which are stored in the MongoDB Atlas `restaurant` database under the `reviews` collection.

The frontend must send a JSON request containing the following fields:

| Field | Type | Description |
|---|---|---|
| `customer_name` | String | Name of the customer submitting the review |
| `rating` | Number | Whole number between 1 and 5 |
| `comment` | String | Customer's written review |

Example request body:

```json
{
  "customer_name": "Alex",
  "rating": 5,
  "comment": "Great food and friendly service."
}
```

The backend checks that the name and comment are not empty and that the rating is a whole number between 1 and 5. If any of these conditions are not met, the server returns HTTP status `400` with an error message.

When a review passes validation, the backend removes leading and trailing whitespace from the name and comment, adds a `created_at` timestamp, and saves the review to MongoDB.

A successful submission returns HTTP status `201` with a response similar to:

```json
{
  "message": "Review submitted successfully",
  "review_id": "MongoDB-generated document ID"
}
```

If the database operation fails, the server returns HTTP status `500`.

The frontend team can use this endpoint to connect the customer review form without directly accessing MongoDB.

## 10. Frontend Integration

The frontend communicates with the backend using JavaScript `fetch()` requests.

For example, the menu can be retrieved using:

```javascript
async function loadMenu() {
    const response = await fetch("/api/menu");

    if (!response.ok) {
        throw new Error("Unable to retrieve menu");
    }

    const dishes = await response.json();
    console.log(dishes);
}
```

Customer reviews can be retrieved in a similar way:

```javascript
async function loadReviews() {
    const response = await fetch("/api/reviews");

    if (!response.ok) {
        throw new Error("Unable to retrieve reviews");
    }

    const reviews = await response.json();
    console.log(reviews);
}
```

These examples retrieve the data but do not display it on the page. The frontend JavaScript will be responsible for formatting and displaying the returned information.

The website's existing `site.js` file handles loading shared HTML components. The database API requests can be added separately without changing the database connection code.

## 11. Integration Testing

An isolated integration test was created to verify that the frontend can retrieve information from both databases.

The test is available at:

`http://localhost:3000/integration-test.html`

It uses browser JavaScript to send GET requests to both API endpoints.

### Test Results

| Test | Result |
|---|---|
| MySQL menu API | Passed – 45 dishes retrieved |
| MongoDB reviews API | Passed – 3 reviews retrieved |
| Browser-to-backend communication | Passed |
| MySQL database export and test import | Passed |
| Imported database table counts | Matched original database |
| Imported ingredient relationships | No invalid references found |

The MySQL export was also imported into a separate `matsuri_test` database to confirm that the tables and records could be recreated.

Both databases are working with the Express backend. The final menu display and review interface still need to be connected and tested.

## 12. Additional Notes

The MySQL database currently runs locally. Ensure you import `matsuri_database.sql` and configure your MySQL connection settings.

MongoDB Atlas is hosted remotely, but the backend still requires valid credentials and network access.

The frontend should use the existing API endpoints rather than connect directly to MySQL or MongoDB. This keeps database configuration in the backend and reduces the chances of frontend changes affecting database connections.

The current integration tests confirm that both databases can return information to browser JavaScript. Further testing will be needed once the menu and review sections are fully implemented.
