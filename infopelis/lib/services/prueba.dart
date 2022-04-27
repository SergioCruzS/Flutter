import 'package:flutter/material.dart';
import 'package:infopelis/models/models.dart';
import 'package:infopelis/services/socket_service.dart';
import 'package:provider/provider.dart';

class PruebaScreen extends StatefulWidget {
  const PruebaScreen({ Key? key }) : super(key: key);

  @override
  State<PruebaScreen> createState() => _PruebaScreenState();
}

class _PruebaScreenState extends State<PruebaScreen> {
  List<Movie> mov = [];

  @override
    void initState() {
      final socketService = Provider.of<SocketService>(context,listen: false);
      print('init ${socketService.serverStatus}');
      socketService.socket.on('movie_cine', (data){
        print(data.length);

        if (data.length != 0) {
          this.mov = (data as List)
                  .map((movie) => Movie.fromMap(movie))
                  .toList();
        } 
        
        setState(() {});
      });

      super.initState();
    }
  
  //Destruir la escucha del socket
  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);

    socketService.socket.off('movie_cine');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child:_titulos()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _titulos() 
      ),
    );


  }

  Widget _titulos (){
    for (int i = 0; i<mov.length;i++) {
      print(mov[i].title);
    }
    return Text('se imprimio');
  }
}