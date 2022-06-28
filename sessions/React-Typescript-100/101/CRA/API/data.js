const getLogin = (req, res) => {
    const username = req.body.userName || 'Cherise';
    const password = req.body.password;
      
    const response = res.status(200).send({ message: 'React 101 login', userId: username });

    return response;
}

module.exports = getLogin;
