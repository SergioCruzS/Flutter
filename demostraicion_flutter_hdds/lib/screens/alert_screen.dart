import 'package:flutter/material.dart';

class AlertScreen extends StatelessWidget {
   
  const AlertScreen({Key? key}) : super(key: key);

  void dialogAndroid(BuildContext context) {
    showDialog(
      barrierDismissible: true, //Presionando fuera se desactiva el diálogo
      context: context, 
      builder: ( context ) {

        return AlertDialog(
          elevation: 5,
          title: const Text('Alerta Emergente'),
          shape: RoundedRectangleBorder( borderRadius: BorderRadiusDirectional.circular(10) ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Contenido de la alerta'),
              SizedBox( height: 10 ),
              Image(image: NetworkImage("https://th.bing.com/th/id/OIP.Z6xK6gNny37eNtITkn8MFgHaIV?pid=ImgDet&rs=1")),
            ],
          ),
          actions: [

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar')
            ),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar')
            ),

          ],
        );
        
      }
    );


  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: ElevatedButton(
           child: const Padding(
             padding: EdgeInsets.symmetric( horizontal: 20, vertical: 15 ),
             child: Text('Mostrar alerta', style: TextStyle( fontSize: 16 )),
           ),
           onPressed: () => dialogAndroid( context )
         ) 
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.close ),
        onPressed: () => Navigator.pop(context) 
      ),
    );
  }
}