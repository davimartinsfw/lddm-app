const { getUserById } = require("./user");
const { runQuery } = require("./database");

async function get() {
  const query = "SELECT * FROM procedures";
  const resp = await runQuery(query);
  return resp;
}

async function create(req) {
  const { params, body } = req;
  // verificar se usuario é admin
  const user = await getUserById({ id: params.userId });
  if (!user.is_admin && !user.is_barber) {
    throw new Error("Apenas administradores fazem o procedimento");
  }

  // criar procedimento
  const query =
    "INSERT INTO procedures (type, duration, price) VALUES (?, ?, ?);";
  const queryObj = {
    type: body.procedure.type,
    duration: body.procedure.duration,
    price: body.procedure.price,
  };

  try {
    const resp = await runQuery(query, Object.values(queryObj));
    return resp;
  } catch (e) {
    throw e;
  }
}

async function update(req) {
  const { params, body } = req;
  // verificar se usuario é admin
  const user = await getUserById({ id: params.userId });
  if (!user.is_admin && !user.is_barber) {
    throw new Error("Apenas administradores atualizam o procedimento");
  }

  // fazer o updade
  const query =
    "UPDATE procedures SET type = ?, duration = ?, price = ? WHERE id = ?";
  const queryObj = {
    type: body.procedure.type,
    duration: body.procedure.duration,
    price: body.procedure.price,
    id: body.procedure.id,
  };

  try {
    const resp = await runQuery(query, Object.values(queryObj));
    return resp;
  } catch (e) {
    throw e;
  }
}

async function remove(params) {
  // verificar se é admin
  const user = await getUserById({ id: params.userId });
  if (!user.is_admin && !user.is_barber) {
    throw new Error("Apenas administradores excluem o procedimento");
  }

  const query = "DELETE FROM procedures WHERE id = ?";

  try {
    const resp = await runQuery(query, [params.procedureId]);
    return resp;
  } catch (e) {
    throw e;
  }
}

async function getProcedureById(id) {
  const query = "SELECT * FROM procedures WHERE id = ?";
  const resp = await runQuery(query, [id]);
  return resp[0];
}

module.exports = {
  get,
  create,
  update,
  remove,
  getProcedureById,
};
