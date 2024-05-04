const { runQuery } = require("./database");
const bcrypt = require("bcrypt");

async function get() {
  const query = "SELECT * FROM user";
  const resp = await runQuery(query);
  return resp;
}

async function getUserById(params) {
  const id = params.id;
  const query = "SELECT * FROM user WHERE id = ?";
  const resp = await runQuery(query, [id]);
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
      name: resp[0].name,
      emailname: resp[0].email,
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
    const resp = await runQuery(query, Object.values(queryObj));
    return resp;
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
function createSchedule(payload) {
  const query = 'INSERT INTO schedule(user_id,barber_id,procedure_id,horario, foto_atual,foto_corte) VALUES (?,?,?,?,?,?)'
  console.log("entrei")
  connection.execute(query, [payload.user_id,payload.barber_id,payload.procedure_id,payload.horario, payload.foto_atual? payload.foto_atual : null,payload.foto_corte? payload.foto_corte : null], (err, rows, columns) => {
    if(err){
      console.log("Erro: "+err)
      return
    }
  })
}

function cancelSchedule(payload) {
  const query = 'DELETE FROM schedule where WHERE id= ?'
  connection.execute(query, [payload.id], (err, rows, columns) => {
    if(err){
      console.log("Erro: "+err)
      return
    }
  })
}

function getAllScheduleUser(payload) {
  const query = 'SELECT * FROM schedule WHERE user_id= ?'
  connection.execute(query, [payload.user_id], (err, rows, columns) => {
    if(err){
      console.log("Erro: "+err)
      return
    }
  })
}
function getAllScheduleBarber(payload) {
  const query = 'SELECT * FROM schedule WHERE barber_id= ?'
  connection.execute(query, [payload.user_id], (err, rows, columns) => {
    if(err){
      console.log("Erro: "+err)
      return
    }
  })
}
function getSchedule(payload) {
  const query = 'SELECT * FROM schedule WHERE id= ?'
  connection.execute(query, [payload.id], (err, rows, columns) => {
    if(err){
      console.log("Erro: "+err)
      return
    }
  })
}

function updadeSchedule(payload) {
  const previous = connection.query('SELECT * FROM schedule WHERE id = ')
  const query = 'UPDATE schedule SET user_id = ?, barber_id = ?, procedure_id, horario = ?, foto_atual = ?, foto_corte = ? WHERE id= ?'
  connection.execute(query, [payload.user_id, payload.barber_id,payload.procedure_id,payload.horario,payload.foto_atual,payload.foto_corte, payload.id], (err, rows, columns) => {
    if(err){
      console.log("Erro: "+err)
      return
    }
  })
}

module.exports = {
  get,
  getUserById,
  login,
  create,
  update,
  remove,
};
