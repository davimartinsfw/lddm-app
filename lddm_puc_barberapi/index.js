import express from "express";
import table from "./src/controllers/table.js";

const app = express();
app.get("/", (req, res) => {
  res.send("epa");
});

app.listen(3000, () => {
  console.log("ta escutando a porta 3000");
  table.createTables();
});
