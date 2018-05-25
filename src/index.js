let express = require('express');
let routes = require('./routes');
let app = express();
app.use(routes);

app.listen(3000, () => {
    console.log('running')
});