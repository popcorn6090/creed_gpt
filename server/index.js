const express = require('express');
const searchRoutes = require('./routes/search');
const http = require('http');
const bodyParser = require('body-parser');
const PORT = 3000;

const app = express();

app.use(bodyParser.json());

app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Acesss-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');

    if(req.method === "OPTIONS"){
        res.header('Access-Control-Allow-Methods', 'PUT, POST, GET, PATCH, DELETE');
        return res.status(200).json({});
    }
    next();
});



app.use('/search', searchRoutes);



app.use((req, res, next) => {
    res.status(200).json({
       message: 'Everything works'
    });
});

const server = http.createServer(app);

server.listen(PORT);


