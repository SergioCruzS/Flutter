
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier{
   
   ServerStatus _serverStatus = ServerStatus.Connecting;

   late IO.Socket _socket;

   ServerStatus get serverStatus => this._serverStatus;
   IO.Socket get socket => this._socket;

   SocketService(){
      _initConfig();
   }

   void _initConfig(){
     // Dart client
       this._socket = IO.io('https://flutter-band-names-server-sgcs.herokuapp.com/',{
         'transports': ['websocket'],
         'autoConnect': true
       });

       this._socket.onConnect((_) {
         print('connect');
         _serverStatus = ServerStatus.Online;
         notifyListeners();
       });

       this._socket.onDisconnect((_) {
         print('Disconnect');
         _serverStatus = ServerStatus.Offline;
         notifyListeners();
       });

       //Escucha en todo momento
       //this._socket.on('nuevo-mensaje',( payload ) {
       //  print('nuevo mensaje: $payload');
       //});
       
   }

}