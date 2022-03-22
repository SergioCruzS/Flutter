import 'package:demostraicion_flutter_hdds/info/info.dart';
import 'package:demostraicion_flutter_hdds/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
   
  const CardScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarjetas"),
        centerTitle: true,
      ),
      body: const CustomCard()
    );
  }
}
