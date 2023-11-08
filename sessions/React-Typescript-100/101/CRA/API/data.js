const data = require('./data.json');

const getRoute = (req, res) => {
  const response = res.status(200).send({ message: 'Success', data: data });
  return response;
};

const getLogin = (req, res) => {
  const username = req.body.userName || 'No username';
  const password = req.body.password || 'No Password';

  const response = res
    .status(200)
    .send({ message: 'Success', userId: data.userId });

  return response;
};

const addPostcode = (req, res) => {
  const userId = req.body.userId || 'No ID provided';
  const postcode = req.body.postcode || 'No postcode';

  const response = res.status(200).send({ message: 'Post Code Added' });

  return response;
};

const deletePostcode = (req, res) => {
  const userId = req.body.userId || 'No ID provided';
  const postcode = req.body.postcode || 'No postcode';

  const response = res.status(200).send({ message: 'Post Code Deleted' });

  return response;
};

const createUser = (req, res) => {
  const username = req.body.userName || 'No username';
  const password = req.body.password || 'No password';

  const response = res
    .status(200)
    .send({ message: 'User Created', userId: data.userId });

  return response;
};

module.exports = {
  getRoute,
  getLogin,
  addPostcode,
  deletePostcode,
  createUser,
};
