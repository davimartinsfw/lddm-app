import { Router } from "express";
import ProcedureController from "../controllers/procedure";
const router = Router();

router.get("/", async (req, res, next) => {
  try {
    res = ProcedureController.get();
    return res;
  } catch (e) {}
});

router.post("/create", async (req, res, next) => {
  try {
    res = ProcedureController.create(req);
  } catch (e) {}
});

router.post("/update/:id", async (req, res, next) => {
  try {
    res = ProcedureController.update(req);
  } catch (e) {}
});

router.delete("/delete/:id", async (req, res, next) => {
  try {
    res = ProcedureController.remove(req);
  } catch (e) {}
});
