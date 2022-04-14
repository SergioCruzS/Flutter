import 'package:band_names/models/band.dart';
import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];

  @override
  void initState() {

    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands',(payload){
      
      this.bands = (payload as List)
         .map((band) => Band.fromMap(band))
         .toList();

      setState(() {});

    });
    super.initState();
    
  }

  //Destruir la escucha del socket
  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);

    socketService.socket.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Band Names', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: ( socketService.serverStatus == ServerStatus.Online ) 
             ? Icon(Icons.check_circle, color: Colors.blue[300],)
             : Icon(Icons.offline_bolt,color: Colors.red),
          )
        ],
      ),
      body:Column(
        children: <Widget>[
          _showGraph(),
          Expanded(
            child: ListView.builder(
               itemCount: bands.length,
               itemBuilder: (context, int index) => _bandTile(bands[index])
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: _addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {

    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        deleteBandToList(band.id);
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
              socketService.socket.emit('vote-band',{'id': band.id});
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
    final socketService = SocketService();
    if (!name.trim().isEmpty){
      socketService.socket.emit('add-band',{'name': name});
    }
    Navigator.pop(context);
  }

  void deleteBandToList( String id ){
    final socketService = SocketService();
    socketService.socket.emit('delete-band',{'id': id});
  }

  //Mostrar Gráfica
  
  Widget _showGraph(){
    Map<String, double> dataMap = new Map();
    if (bands.isEmpty){
      dataMap.putIfAbsent('No data', () => 0.0);
    }else{
      bands.forEach((band) {
      dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
     });
    }
    

    return Container(
      width: double.infinity,
      height: 200,
      child: PieChart(dataMap: dataMap)
    ) ;
  }

}