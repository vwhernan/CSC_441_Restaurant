
const mysql = require('mysql2/promise');

// Create a pool of connections to the MySQL database
const pool = mysql.createPool({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
    port: Number(process.env.MYSQL_PORT || 3306),
    waitForConnections: true,
    connectionLimit: 10
});

// Allow other files to use the connection pool
module.exports = pool;
