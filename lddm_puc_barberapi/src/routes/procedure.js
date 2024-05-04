const { Router } = require("express");
const ProcedureController = require("../controllers/procedure");
const router = Router();

router.get("/", async (req, res, next) => {
  try {
    const response = await ProcedureController.get();
    res.status(200).send(response);
  } catch (e) {
    res.status(500).send(e)
  }
});

router.get("/:id", async (req, res, next) => {
  try {
    const response = await ProcedureController.getProcedureById(req.params?.id);
    res.status(200).send(response);
  } catch (e) {
    res.status(500).send(e)
  }
});

router.post("/create/:userId", async (req, res, next) => {
  try {
    const response = await ProcedureController.create(req);
    res.status(201).send(response);
  } catch (e) {
    res.status(500).send(e)
  }
});

router.post("/update/:userId", async (req, res, next) => {
  try {
    const response = await ProcedureController.update(req);
    res.status(200).send(response);
  } catch (e) {
    res.status(500).send(e)
  }
});

router.delete("/delete/:procedureId/:userId", async (req, res, next) => {
  try {
    const response = await ProcedureController.remove(req.params);
    res.status(200).send(response);
  } catch (e) {
    res.status(500).send(e)
  }
});

module.exports = {
  router
}
