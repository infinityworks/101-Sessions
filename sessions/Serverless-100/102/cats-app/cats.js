const { promisify } = require('util');
const fs = require('fs');

const listImages = () => {
    return promisify(fs.readdir)('./img');
};

const getImage = filename => {
    return promisify(fs.readFile)(`./img/${filename}`);
};

const putImage = (filename, data) => {
    return promisify(fs.writeFile)(`./img/${filename}`, data);
};

module.exports = { listImages, getImage, putImage };