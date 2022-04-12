const { io } = require('../index');

io.on('connection', client =>{
    console.log('Cliente conectado');
   // client.on('event',data => {});
    client.on('disconnect', () =>{
        console.log('Cliente desconectado');
    });

    client.on('mensaje',(payload) =>{
        console.log('Mensaje',payload.nombre);

        io.emit( 'mensaje', {admin: 'mensaje del server'});
    })
});