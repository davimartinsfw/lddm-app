import mysql from "mysql2";
import { config } from "dotenv";

config({ path: ".env" });

const connection = mysql.createConnection({
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  database: process.env.MYSQL_DATABASE,
  password: process.env.MYSQL_PASSWORD,
  port: 3306,
  connectTimeout: 30000
});

const createTablesQuery = `
  CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(80) NOT NULL,
    password VARCHAR(255) NOT NULL,
    is_admin BOOLEAN,
    is_barber BOOLEAN,
    is_clube BOOLEAN,
    data_nasc DATE,
    telefone VARCHAR(11) NOT NULL
  );
`;

function createTables() {
  connection.query(createTablesQuery, (err, results, fields) => {
    console.log("results", results);
    console.log("fields", fields);
    if (err) {
      console.error("Erro ao criar a tabela:", err);
      return;
    }
    console.log("Tabela criada com sucesso!");

    // Fechar a conexão com o banco de dados após a criação da tabela
    connection.end();
  });
}

export default {
  createTables,
};
