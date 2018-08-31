let express = require('express');
let app = express();
let routes = express.Router();

routes.get('/', function (req, res) {
    res.send('Hello world!!');
});
routes.get('/test', function (req, res) {
    res.send('Hello world!! /test');
});

routes.get('/test2', function (req, res) {
    res.send('Hello world!! /test2');
});
routes.get('/test3', function (req, res) {
    res.send('Hello world!! /test3');
});
app.use('/simplejs', routes);

app.listen(3000, () => {
    console.log('running')
});