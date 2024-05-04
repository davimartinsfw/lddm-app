//const { getUserById } = require("./user");

const { runQuery, createConnection } = require("./database");
const bcrypt = require('bcrypt')

async function get() {
  const query = "SELECT * FROM procedure";
  const resp = await runQuery(query);
  return resp;
}

async function create(payload) {
  // verificar se usuario é admin
  const user = await getUserById(payload.userId);
  if(!user.is_admin) {
    throw new Error("Apenas administradores fazem o procedimento")
  }

  // verificar se procedimento
  const existingProcedure = await getProcedureByName(payload.name);
  if(existingProcedure) {
    throw new Error("Procedimento já existe");
  }

  // criar procedimento
  const query = "INSERT INTO procedure (type, duration, time, price, actualPic, cortePic) VALUES (?, ?, ?, ?, ?, ?);";
  const queryObj = {
    type: payload.type,
    duration: payload.duration,
    time: payload.time,
    price: payload.price,
    actualPic: payload.actualPic,
    cortePic: payload.cortePic,
  };

  try {
    const resp = await runQuery(query, Object.values(queryObj));
    return resp;
  } catch (e) {
    throw e;
  }
}

async function update(payload) {
  // verificar se usuario é admin
  const user = await getUserById(payload.userId);
  if(!user.is_admin) {
    throw new Error("Apenas administradores atualizam o procedimento")
  }
  // verificar se o procedimento existe
  const procedure = await getProcedureById(payload.id);
  if(!procedure) {
    throw new Error("Procedimento não encontrado");
  }

  // fazer o updade
  const query = "UPDATE procedures SET type = ?, duration = ?, time = ?, price = ?, actualPic = ?, cortePic = ?";
  const queryObj = {
    type: payload.type,
    duration: payload.duration,
    time: payload.time,
    price: payload.price,
    actualPic: payload.actualPic,
    cortePic: payload.cortePic,
  };

  try {
    const resp = await runQuery(query, Object.values(queryObj));
    return resp;
  } catch (e) {
    throw e;
  }
}

async function remove(payload) {
  // verificar se é admin
  const user = await getUserById(payload.userId);
  if(!user.is_admin) {
    throw new Error("Apenas administradores excluem o procedimento")
  }

  // verificar se o procedimento existe
  const procedure = await getProcedureById(payload.id);
  if(!procedure) {
    throw new Error("Procedimento não encontrado");
  }

  const query = "DELETE FROM procedures WHERE id = ?";

  try {
    const resp = await runQuery(query, [payload.id]);
    return resp;
  } catch (e) {
    throw e;
  }
}

async function getUserById(id) {
  const query = "SELECT * FROM user WHERE id = ?";
  const resp = await runQuery(query, [id]);
  return resp[0];
}

async function getProcedureByName(name) {
  const query = "SELECT * FROM procedures WHERE name = ?";
  const resp = await runQuery(query, [name]);
  return resp[0];
}

async function getProcedureById(id) {
  const query = "SELECT * FROM procedures WHERE id = ?";
  const resp = await runQuery(query, [id]);
  return resp[0];
}

module.exports= {
  get
};
