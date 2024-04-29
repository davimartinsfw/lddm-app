function get() {
  // db.getProcedures
  return;
}

function create(payload) {
  // verificar se usuario é admin
  // verificar se procedimento
  // criar usuario
  // return que usuario foi criado
}

function update(payload) {
  // verificar se usuario é admin
  // verificar o que mudou
  // fazer o updade
  // return usuario atualizado
}

function remove(payload) {
  // verificar se é admin
  // verificar se o id existe
  // se existir deletar procedimento
}

export default {
  get,
  create,
  update,
  remove,
};
