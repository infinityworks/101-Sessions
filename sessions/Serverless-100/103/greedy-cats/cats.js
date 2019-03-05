const { promisify } = require('util');
const AWS = require('aws-sdk');

const listImages = () => {
  var s3 = new AWS.S3();
  return s3.listObjectsV2({
    Bucket: 'cats-app-image-bucket-3'
  })
    .promise()
    .then(bucket => bucket.Contents.map(file => file.Key));
};

const getImage = filename => {
  var s3 = new AWS.S3();
  return s3.getObject({
    Bucket: 'cats-app-image-bucket-3',
    Key: filename,
  })
    .promise()
    .then(file => file.Body);
};

const putImage = (filename, data) => {
  var s3 = new AWS.S3();
  return s3.putObject({
    Bucket: 'cats-app-image-bucket-3',
    Key: filename,
    Body: data,
    ContentType: 'image/jpeg',
  }).promise();
};

const validateImage = data => {
  let rekognition = new AWS.Rekognition();
  return rekognition.detectLabels({
    Image: {
      Bytes: data,
    },
  })
    .promise()
    .then(result => {
      console.log(result.Labels.map(label => label.Name));
      return result.Labels.some(label => label.Name === 'Cat') ? true : result.Labels[0].Name;
    });
};

const requestPayment = data => {
  console.log(data);
  console.log(daya.dynamodb);
}

module.exports = { listImages, getImage, putImage, validateImage, requestPayment };