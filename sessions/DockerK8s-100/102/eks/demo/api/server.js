"use strict";

const express = require("express");
const fetch = require("node-fetch");

const app = express();
const port = 80;

app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  next();
});

app.get("/", (req, res) => {
  res.status(404).send("Nothing to see here...");
});

app.get("/api/attendees", async (req, res) => {
  await fetch(
    "https://api.meetup.com/Infinity-Works-101-Sessions/events/260602995/rsvps?&sign=true&photo-host=secure&only=member&response=yes"
  )
    .then(response => response.json())
    .then(json => res.status(200).json({ attendees: json }))
    .catch(error => {
      res.status(500).json({ error: error });
    });
});

app.listen(port, () => {
  console.info("🙃 listening on port", port);
});
