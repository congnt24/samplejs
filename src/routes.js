let express = require('express');

let routes = express.Router();

/* This route is used for Server monitor */
routes.get('/', function (req, res) {
    res.send('Hello world!! Home');
});

routes.get('/test', function (req, res) {
    res.send('Hello world!!');
});

module.exports = routes;