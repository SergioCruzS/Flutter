import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'band 1', votes: 5),
    Band(id: '2', name: 'band 2', votes: 6),
    Band(id: '3', name: 'band 3', votes: 2),
    Band(id: '4', name: 'band 4', votes: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Band Names', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body:ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, int index) => _bandTile(bands[index])
 
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: _addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        //borrar
      },
      background: Container(
        color: Colors.redAccent,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Eliminar banda',style: TextStyle(color: Colors.white),),
        ),
      ),
      child: ListTile(
            leading: CircleAvatar(
              child: Text(band.name.substring(0,2)),
              backgroundColor: Colors.green[100],
            ),
            title: Text(band.name),
            trailing: Text('${band.votes}',style: TextStyle(fontSize: 20),),
            onTap: (){
              print(band.name);
            },
      ),
    );
  }

  _addNewBand (){
    final textController = new TextEditingController();
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Nueva banda: '),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              child: Text('Agregar'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => addBandToList(textController.text)
            )
          ],
        );
      }
    );
  }


  void addBandToList( String name ){
    if (!name.trim().isEmpty){
      this.bands.add(new Band(id: '1', name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}