import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String subtitle){

  showDialog(
    context: context, 
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        MaterialButton(
          child: Text('Aceptar'),
          elevation: 5,
          onPressed: () => Navigator.pop(context)
        )
      ],
    )
  );
}