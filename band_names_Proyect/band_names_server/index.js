const express = require('express');
const path = require('path');
require('dotenv').config();

const app = express();


// Path público
const publicPath = path.resolve( __dirname, 'public' );

app.use( express.static( publicPath ));


app.listen(process.env.PORT, ( err ) => {
    if (err) throw new Error(err);

    console.log('Servidor Corriendo en puerto', process.env.PORT );
});