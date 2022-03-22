import 'package:flutter/material.dart';

class AvatarScreen extends StatelessWidget {
   
  const AvatarScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only( right: 5),
            child: CircleAvatar(
              child: const Text('R'),
              backgroundColor: Colors.indigo[900]
            ),
          )
        ],
      ),
      body: const Center(
         child: CircleAvatar(
           maxRadius: 50,
           backgroundImage: NetworkImage('https://i.blogs.es/0580cd/avatar.endgame/1366_2000.jpeg')
         )
      ),
    );
  }
}