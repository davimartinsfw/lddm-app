const { Router, response } = require("express");
const UserController = require("../controllers/user");
const { config } = require("dotenv");

config({ path: ".env" });
const router = Router();

router.get("/", async (req, res, next) => {
  try {
    const response = await UserController.get();
    res.status(200).send(response);
  } catch (e) {
    res.status(500).send(e);
  }
});

router.get("/:id", async (req, res, next) => {
  try {
    const response = await UserController.getUserById(req.params);
    res.status(200).send(response);
  } catch (e) {
    res.status(500).send(e);
  }
});

router.post("/login", async (req, res, next) => {
  try {
    const response = await UserController.login(req.body);
    if (response) {
      res.status(200).send(response);
    } else {
      res.sendStatus(401);
    }
  } catch (e) {
    res.sendStatus(500);
  }
});

router.post("/create", async (req, res, next) => {
  try {
    const response = UserController.create(req.body);
    res.status(201).send(response);
  } catch (e) {
    res.status(500).send(e);
  }
});

router.post("/update/:id", async (req, res, next) => {
  try {
    const response = UserController.update(req);
    res.status(200).send(response);
  } catch (e) {
    res.status(500).send(e);
  }
});

router.delete("/delete/:id", async (req, res, next) => {
  try {
    const response = UserController.remove(req.params);
    res.status(200).send(response);
  } catch (e) {
    res.status(500).send(e);
  }
});

module.exports = { router };
