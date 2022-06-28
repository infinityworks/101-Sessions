const  getLogin = require('./data');

const express = require('express');

const app = express();

app.use(express.json());

const port = 5001;

app.listen(port, () =>
  console.log(`React 101 server Listening on port ${port}`)
);

app.get('/', (req, res) => {
  res.status(200).send({ message: 'React 101 Route' });
});

app.get('/login', getLogin);

