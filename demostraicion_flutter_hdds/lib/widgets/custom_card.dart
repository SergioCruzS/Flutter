import 'package:demostraicion_flutter_hdds/info/info.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:[
        ...CardInfo.contentCard.map((card) => Card(
          color: Colors.blue[100],
          child: ListTile(
              title: Text(card.title),
              subtitle: Text(card.content),
            ),
        ))
      ],
    );
  }
}
