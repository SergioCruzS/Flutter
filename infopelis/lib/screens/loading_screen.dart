import 'package:flutter/material.dart';
import 'package:infopelis/services/socket_service.dart';
import 'package:infopelis/widgets/alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<SocketService>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(185, 134, 201, 230),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie_filter_rounded,size: 200,color: Colors.black),
            SizedBox(height: 70,),
            Container(
              child: moviesProvider.serverStatus == ServerStatus.Connecting ? Container(
                width: 100,
                child: LinearProgressIndicator(
                  color: Colors.red,
                ),
              ) : ElevatedButton(
                onPressed: (() {
                if (moviesProvider.onDisplayMovies.length == 0) {
                  showAlertDialog(context, "Error con el Servidor", "Ocurrió un error, por favor reinicie la aplicación.");
                }else{
                  Navigator.pushReplacementNamed(context, 'home');
                }
              }), 
                child: const Text('Ingresar'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  elevation: 10,
                  minimumSize: Size(300, 50)
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}