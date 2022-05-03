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
      backgroundColor: Colors.cyan[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie_filter_rounded,size: 200,),
            SizedBox(height: 70,),
            Container(
              width: 100,
              child: moviesProvider.serverStatus == ServerStatus.Connecting ? LinearProgressIndicator(
                color: Colors.red,
              ) : ElevatedButton(onPressed: (() {
                if (moviesProvider.onDisplayMovies.length == 0) {
                  showAlertDialog(context, "Error con el Servidor", "Ocurrió un error, por favor reinicie la aplicación.");
                }else{
                  Navigator.pushReplacementNamed(context, 'home');
                }
              }), child: Text('Ingresar')),
            )
          ],
        ),
      ),
    );
  }
}