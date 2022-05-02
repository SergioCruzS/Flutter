import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infopelis/services/auth_service.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Datos del usuario'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _UserData(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green
                  ),
                  onPressed: (){
                  }, 
                  child: Text('Ver mis favoritos')
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red
                  ),
                  onPressed: (){
                    final authService = Provider.of<AuthService>(context, listen: false);
                    authService.logout();
                    Navigator.pop(context);
                  }, 
                  child: Text('Cerrar Sesión')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _UserData extends StatefulWidget {
  @override
  State<_UserData> createState() => __UserDataState();
}

class __UserDataState extends State<_UserData> {
  
  final nameController = TextEditingController(text: AuthService.data['name']);
  final emailController = TextEditingController(text: AuthService.data['email']);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          _CustomFormTextField(
            icon: Icons.account_circle_outlined, 
            placeholder: 'Nombre',  
            textController: nameController
          ),
          _CustomFormTextField(
            icon: Icons.email_outlined, 
            placeholder: 'Email',  
            textController: emailController
          ),
          
        ],
      ),
    );
  }
}

class _CustomFormTextField extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool active;

  const _CustomFormTextField({
    Key? key, 
    required this.icon, 
    required this.placeholder,  
    required this.textController, 
    this.keyboardType = TextInputType.text, 
    this.isPassword = false,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0,5),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        autocorrect: false,
        keyboardType: this.keyboardType,
        decoration: (InputDecoration(
          prefixIcon: Icon(this.icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeholder
        )),
        controller: textController,
        obscureText: this.isPassword,
        enabled: active,
      )
    );
  }
}