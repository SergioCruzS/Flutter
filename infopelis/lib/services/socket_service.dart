import 'package:flutter/cupertino.dart';
import 'package:infopelis/models/models.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


enum ServerStatus{
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier{

  ServerStatus _serverStatus = ServerStatus.Connecting;
  
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topMovies = [];

  SocketService(){
    _initConfig();
  }

  void _initConfig(){
    this._socket = IO.io('http://192.168.228.62:3000/',{
      'transports':['websocket'],
      'autoConnect':true
    });
    
    this._socket.onConnect(
      (_){
        print('connect');
        _serverStatus = ServerStatus.Online;
        notifyListeners();
      }
    );

    this._socket.onDisconnect((_){
      print('Desconectado');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.on('onDisplayMovies', (data){
        print(data.length);
        if (data.length != 0) {
          this.onDisplayMovies = (data as List)
                  .map((movie) => Movie.fromMap(movie))
                  .toList();
        }
        notifyListeners();  
    });


    this._socket.on('popularMovies', (data){
        print('popularmovies');
        if (data.length != 0) {
          this.popularMovies = (data as List)
                  .map((movie) => Movie.fromMap(movie))
                  .toList();
        }
        notifyListeners();  
    });
  }

}