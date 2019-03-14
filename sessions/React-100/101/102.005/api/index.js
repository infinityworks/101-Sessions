const express = require('express');
var cors = require('cors');
var sleep = require('sleep-promise');

const app = express();
const port = 3000;
app.use(cors());

const data = {
  count: 0,
};

app.get('/count', (req, res) => {
  console.log("GET received");
  res.send(data);
  // res.error("fail")
});

app.post('/count/increment', async (req, res) => {
  console.log(`POST received ${data.count}`);
  data.count ++;
  await sleep(2000);
  res.send(data);
  // res.error("fail")
});

app.post('/count/decrement', async (req, res) => {
  console.log(`POST received ${data.count}`);
  data.count --;
  await sleep(2000);
  res.send(data);
  // res.error("fail")
});

app.listen(port, () => console.log(`API listening on port ${port}!`))