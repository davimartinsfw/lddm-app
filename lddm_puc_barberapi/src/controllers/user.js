import mysql from "mysql2/promise";

const connection = mysql.createConnection({
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  database: process.env.MYSQL_DATABASE,
  password: process.env.MYSQL_PASSWORD,
});

function get() {
  // db.getUsers
  return;
}

function create(payload) {
  // verificar se existe usuario com esse email
  // criar usuario
  // return que usuario foi criado
}

function update(payload) {
  // verificar o que mudou
  // se tiver mudado o email verificar se esse email já existe
  // fazer o updade
  // return usuario atualizado
}

function remove(payload) {
  // verificar se é admin
  // verificar se o id existe
  // se existir deletar usuario
}

function createSchedule(payload) {}

function cancelSchedule(payload) {}

function getSchedule(payload) {}

function updadeSchedule(payload) {}

export default {
  get,
  create,
  update,
  remove,
};
