const { runQuery } = require("./database");
const bcrypt = require("bcrypt");

async function get() {
  const query =
    "SELECT id, name, email, phone_number, is_admin, is_clube, is_barber FROM user";
  const resp = await runQuery(query);
  return resp;
}

async function getUserById(params) {
  const id = params.id;
  const query = "SELECT * FROM user WHERE id = ?";
  const resp = await runQuery(query, [id]);
  return resp[0];
}

async function getBarbers() {
  const query = "SELECT name, id FROM user WHERE is_barber = 1";
  const resp = await runQuery(query);
  return resp;
}

async function getAdmins() {
  const query =
    "SELECT name, email, phone_number, id FROM user WHERE is_barber = 1";
  const resp = await runQuery(query);
  return resp[0];
}

async function login(payload) {
  const email = payload.email;
  const password = payload.password;
  const query = "SELECT * FROM user where email = ?";
  const resp = await runQuery(query, [email]);
  const dbPassword = resp[0].password;
  const isValid = await bcrypt.compare(password, dbPassword);
  if (isValid) {
    return {
      id: resp[0].id,
      name: resp[0].name,
      email: resp[0].email,
      is_admin: resp[0].is_admin,
      is_barber: resp[0].is_barber,
      is_clube: resp[0].is_clube,
      phone_number: resp[0].phone_number,
    };
  } else {
    return false;
  }
}

async function create(payload) {
  const salt = await bcrypt.genSalt(10);
  const query =
    "INSERT INTO user (name, email, password, is_admin, is_barber, is_clube, date_birth, phone_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
  const password = await bcrypt.hash(payload.user.password, salt);
  const dateBirth = new Date(payload.user.date_birth);
  const queryObj = {
    name: payload.user.name,
    email: payload.user.email,
    password,
    is_admin: payload.user.is_admin,
    is_barber: payload.user.is_barber,
    is_clube: payload.user.is_clube,
    date_birth: dateBirth,
    phone_number: payload.user.phone_number,
  };
  try {
    await runQuery(query, Object.values(queryObj));
    return await login({
      email: payload.user.email,
      password: payload.user.password,
    });
  } catch (e) {
    throw e;
  }
}

async function update({ params, body }) {
  const user = body.user;
  let dateBirth = new Date(user.date_birth);
  const queryObj = {
    name: user.name,
    email: user.email,
    password: user.password,
    is_admin: user.is_admin,
    is_barber: user.is_barber,
    is_clube: user.is_clube,
    date_birth: dateBirth,
    phone_number: user.phone_number,
    id: params.id,
  };
  const query =
    "UPDATE user SET name = ?, email = ?, password = ?, is_admin = ?, is_barber = ?, is_clube = ?, date_birth = ?, phone_number = ? WHERE id = ?";
  try {
    const resp = await runQuery(query, Object.values(queryObj));
    return resp;
  } catch (e) {
    throw e;
  }
}

async function remove(params) {
  const query = "DELETE FROM user WHERE id = ?";
  try {
    const resp = await runQuery(query, [params.id]);
    return resp;
  } catch (e) {
    throw e;
  }
}
async function createSchedule(payload) {
  const query = 'INSERT INTO schedule(user_id,barber_id,procedure_id,horario, foto_atual,foto_corte) VALUES (?,?,?,?,?,?)'
  const queryObj = {
    user_id: payload.user_id,
    barber_id: payload.barber_id,
    procedure_id: payload.procedure_id,
    horario: payload.horario,
    foto_atual: payload.foto_atual,
    foto_corte: payload.foto_corte,
    descricao: payload.descricao,
  };
  try {
    const resp = await runQuery(query, Object.values(queryObj));
    return resp;
  } catch (e) {
    throw e;
  }
}

async function cancelSchedule(payload) {
  const query = 'DELETE FROM schedule where WHERE id= ?'
  try {
    const resp = await runQuery(query, payload.id);
    return resp;
  } catch (e) {
    throw e;
  }
}

async function getUserSchedule(payload) {
  const query = 'SELECT * FROM schedule WHERE user_id= ?'
  try {
    const resp = await runQuery(query, payload.user_id);
    return resp;
  } catch (e) {
    throw e;
  }
}
async function getBarberSchedule(payload) {
  const query = 'SELECT * FROM schedule WHERE barber_id= ?'
  try {
    const resp = await runQuery(query, payload.barber_id);
    return resp;
  } catch (e) {
    throw e;
  }
}

async function getSchedule(payload) {
  const query = `SELECT * FROM schedule WHERE id = ?`
  try {
    const resp = await runQuery(query, payload.id);
    console.log(resp)
    return resp;
  } catch (e) {
    throw e;
  }
}
//Requisicao de horario inicio + duracao para calendario
async function getBarberTimes(payload) {
  const query = `SELECT s.horario AS horario, p.duration AS procedure_duration
  FROM schedule s
  JOIN procedures p ON s.procedure_id = p.id where barber_id = ? and horario LIKE ?
  `
  try {
    const resp = await runQuery(query, [payload.barber_id, payload.horario+'%']);
    console.log(resp)
    return resp;
  } catch (e) {
    throw e;
  }
}

async function updateSchedule(payload) {
  const query = 'UPDATE schedule SET user_id = ?, barber_id = ?, procedure_id = ?, horario = ?, foto_atual = ?, foto_corte = ?, descricao = ? WHERE id = ?'
  const queryObj = {
    user_id: payload.user_id,
    barber_id: payload.barber_id,
    procedure_id: payload.procedure_id,
    horario: payload.horario,
    foto_atual: payload.foto_atual,
    foto_corte: payload.foto_corte,
    descricao: payload.descricao,
    id: payload.id
  };
  try {
    const resp = await runQuery(query, Object.values(queryObj));
    console.log(resp)
    return resp;
  } catch (e) {
    throw e;
  }
}
module.exports = {
  get,
  getUserById,
  getAdmins,
  getBarbers,
  login,
  create,
  update,
  remove,
  createSchedule,
  cancelSchedule,
  getUserSchedule,
  getBarberSchedule,
  getSchedule,
  updateSchedule,
  getBarberTimes
};
