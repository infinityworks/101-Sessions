const {
  getRoute,
  getLogin,
  addPostcode,
  deletePostcode,
  createUser,
} = require('./data');
const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());

app.use(express.json());

const port = 5001;

app.listen(port, () =>
  console.log(`React 101 server Listening on port ${port}`)
);

app.get('/', getRoute);
app.get('/login', getLogin);
app.post('/add-postcode', addPostcode);
app.delete('/delete-postcode', deletePostcode);
app.post('/create-user', createUser);
