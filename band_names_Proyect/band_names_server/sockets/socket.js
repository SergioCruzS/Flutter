const { io } = require('../index');
const Band = require('../models/band');
const Bands = require('../models/bands');

const bands = new Bands();

bands.addBand(new Band('Comisario'));
bands.addBand(new Band('Queen'));
bands.addBand(new Band('Caligaris'));
bands.addBand(new Band('Heroes del Silencio'));

io.on('connection', client =>{
    console.log('Cliente conectado');

    client.emit('active-bands', bands.getBands() );

   // client.on('event',data => {});
    client.on('disconnect', () =>{
        console.log('Cliente desconectado');
    });

    client.on('mensaje',(payload) =>{
        console.log('Mensaje',payload.nombre);

        io.emit( 'mensaje', {admin: 'mensaje del server'});
    })


    client.on('emitir-mensaje',(payload) => {
        //io.emit('nuevo-mensaje','nuevoooooooooooo') //Emite a todos
        client.broadcast.emit('nuevo-mensaje',payload); //Emite a todos menos el que lo emitió

    })
    
    client.on('vote-band',(payload) => {
        bands.voteBand(payload.id);
        io.emit('active-bands',bands.getBands());
    })

    client.on('add-band',(payload) => {
        bands.addBand(new Band(payload.name));
        io.emit('active-bands',bands.getBands());
    })
    
    client.on('delete-band',(payload) => {
        bands.deleteBand(payload.id);
        io.emit('active-bands',bands.getBands());
    })


});