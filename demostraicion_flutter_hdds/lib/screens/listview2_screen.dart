
import 'package:flutter/material.dart';

class Listview2Screen extends StatelessWidget {
   
  final options = const['Matemáticas','Cálculo Diferencial','Cálculo Integral','Español','Física','Ecuaciones Diferenciales','Programación','Geografía','Taller de investigación','Desarrollo sustentable','Inglés','Sistemas Operativos'];

  const Listview2Screen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listview Tipo 2')
      ),
      body: ListView.separated(
        itemCount: options.length,
        itemBuilder: (context, i) => ListTile( 
          title: Text( options[i] ),
          trailing: const Icon( Icons.arrow_forward_ios_outlined, color: Colors.indigo, ),
          onTap: () {
            final game = options[i];
            print( game );
          },
        ), 
        separatorBuilder: ( _ , __ ) => const Divider(), 
      )
    );
  }
}

