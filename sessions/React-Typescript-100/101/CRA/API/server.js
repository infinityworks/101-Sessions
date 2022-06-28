const  {getLogin, addPostcode, deletePostcode} = require('./data');

const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());

app.use(express.json());

const port = 5001;

app.listen(port, () =>
  console.log(`React 101 server Listening on port ${port}`)
);

app.get('/', (req, res) => {
  res.status(200).send({ message: 'React 101 Route' });
});

app.get('/login', getLogin);
app.post('/add-postcode', addPostcode);
app.delete('/delete-postcode', deletePostcode);

