const getLogin = (req, res) => {
    const username = req.body.userName || 'Cherise';
    const password = req.body.password;
      
    const response = res.status(200).send({ message: 'React 101 login', userId: username });

    return response;
}

const addPostcode = (req, res) => {
    const userId = req.body.userId || 'No ID provided';
    const postcode = req.body.postcode || 'No postcode';

    const response = res.status(200).send({message: 'Success'});

    return response;
}

module.exports = { 
    getLogin, 
    addPostcode
};
