const express = require("express");
const user = require("./src/routes/user.js");

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.get("/", (req, res) => {});
app.use("/api/user", user.router);

app.listen(3000, () => {
  console.log("ta escutando a porta 3000");
});
