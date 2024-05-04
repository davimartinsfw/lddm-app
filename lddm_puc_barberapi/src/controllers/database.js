const mysql = require("mysql2/promise");
const { config } = require("dotenv");

config({ path: ".env" });

const createTablesQuery = `
  CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(80) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    is_admin BOOLEAN,
    is_barber BOOLEAN,
    is_clube BOOLEAN,
    date_birth DATE,
    phone_number VARCHAR(11) NOT NULL
  );
`;
const createTableSchedule = `CREATE TABLE IF NOT EXISTS schedule(
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    barber_id INT NOT NULL,
    procedure_id INT NOT NULL,
    horario TIMESTAMP NOT NULL,
    foto_atual BINARY,
    foto_corte BINARY
  );`
async function createConnection() {
  return await mysql.createConnection({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    database: process.env.MYSQL_DATABASE,
    password: process.env.MYSQL_PASSWORD,
    port: 3306,
    connectTimeout: 30000,
  });
}

async function runQuery(query, obj = {}) {
  const connection = await createConnection();
  try {
    connection.prepare(query, obj);
    const [rows, fields] = await connection.query(query, obj);
    return rows;
  } catch (error) {
    throw error;
  }
}

async function createTables() {
  const connection = await createConnection();
  try {
    await connection.query(createTablesQuery);
    await connection.query(createTableSchedule);
  } catch (e) {
    throw e;
  } finally {
    await connection.end();
  }
}

module.exports = {
  createTables,
  createConnection,
  runQuery,
};
