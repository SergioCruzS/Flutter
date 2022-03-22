import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  //Opciones para la lista
  final options = const ['Espacio 1', 'Espacio 2', 'Espacio 3', 'Espacio 4'];
  const ListViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Demostración'),
        ),
        body: ListView.separated(
          itemCount: options.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(options[index]), //Título
            trailing:
                const Icon(Icons.arrow_forward_ios), //Icono de lado derecho
            onTap: () {},
          ),
          separatorBuilder: (context, index) => const Divider(),
        ));
  }
}
