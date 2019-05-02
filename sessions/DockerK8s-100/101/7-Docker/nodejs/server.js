"use strict";

const express = require("express");

const app = express();

app.get("/", (req, res) => {
  res.send("Hello 101ers!");
});

app.listen(8080);
