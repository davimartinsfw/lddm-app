const { Router } = require("express");
const UserController = require("../controllers/user");
const { config } = require("dotenv");

config({ path: ".env" });
const router = Router();

router.get("/barbers/", async (req, res, next) => {
  try {
    const response = await UserController.getBarbers();
    res.status(200).send(response);
  } catch (e) {
    res.status(500).send(e);
  }
});

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
router.get("/schedule/:id", async (req, res, next) => {
  try {
    const response = await UserController.getSchedule();
    res.status(200).send(response)
  } catch (e) {
    res.status(500).send(e)}
});
router.get("/uschedule/:id", async (req, res, next) => {
  try {
    const response = await UserController.getAllSchedule();
    res.status(200).send(response)
  } catch (e) {
    res.status(500).send(e)}
});
router.get("/bschedule/:id", async (req, res, next) => {
  try {
    const response = await UserController.getAllScheduleBarber();
    res.status(200).send(response)
  } catch (e) {
    res.status(500).send(e)}
});
router.post("/schedule", async (req, res, next) => {
  try {
    const response = UserController.createSchedule(req.body);
    res.status(201).send(response)
  } catch (e) {
    res.status(500).send(e)
  }
});
router.post("/editschedule", async (req, res, next) => {
  try {
    const response = UserController.updateSchedule(req.body);
    res.status(201).send(response)
  } catch (e) {
    res.status(500).send(e)
  }
});
router.delete("/cancel/:id", async (req, res, next) => {
	try {
    const response = UserController.cancelSchedule(req);
    res.status(200).send(response)
  } catch (e) {
    res.status(500).send(e)
  }
});
module.exports = { router };
