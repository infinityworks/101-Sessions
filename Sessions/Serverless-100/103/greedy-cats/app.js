const express = require('express');
const bodyParser = require('body-parser');
const uuidv1 = require('uuid/v1');
const imageDataURI = require('image-data-uri');
const serverless = require('serverless-http');
const cookieParser = require('cookie-parser');

const cats = require('./cats');
const { getRandomIndex } = require('./random');

// The base http handler describing this API.
const app = express();

// Parse cookies.
app.use(cookieParser());

// Parse json.
app.use(bodyParser.json({ limit: '10mb' }));

// Statically serve the client directory from this endpoint.
app.use(express.static('./client'));

// Turn off CORS protection.
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Credentials', 'true');
  next();
});

// Endpoint to return a random image of a cat (as binary image data).
app.get('/cats/random', (req, res) => {
  res.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');

  cats.listImages()
    .then(list => {
      let index = getRandomIndex(list.length, req.cookies.lastCatIndex || 0);
      res.cookie('lastCatIndex', index);
      return cats.getImage(list[index]);
    })
    .then(buffer => imageDataURI.encode(buffer, 'JPEG'))
    .then(image => res.json({ image }))
    .catch(err => res.status(500).send(err.toString()));
});

// Endpoint to upload a new cat image (sent through multipart form data).
app.post('/cats', (req, res) => {
  let fileName = `${uuidv1()}.jpeg`;
  let fileData = Buffer.from(req.body.image, 'base64');

  /*
   *cats.validateImage(fileData)
   *  .then(result => result===true ? null : Promise.reject('Image is not a cat! It\'s a '+result))
   *  .then(() => cats.putImage(fileName, fileData))
   *  .then(() => res.redirect(req.header('Referer')))
   *  .catch(err => res.status(400).send(err.toString()));
   */

  cats.validateImage(fileData)
  cats.putImage(fileName, fileData)
    .then(() => res.redirect(req.header('Referer')))
    .catch(err => res.status(400).send(err.toString()));
});

// Start handling lambda requests
module.exports.handler = serverless(app);