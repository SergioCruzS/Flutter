import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infopelis/global/enviroment.dart';
import 'package:infopelis/services/auth_service.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                SizedBox(height: 20*(size.height/Enviroment.height),),
                Container(
                  width: 300*(size.width/Enviroment.width),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      minimumSize: Size(300*(size.width/Enviroment.width), 100*(size.height/Enviroment.height))
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, 'favorite');
                    }, 
                    child: Text('Ver mis favoritos')
                  ),
                ),
                SizedBox(height: 40*(size.height/Enviroment.height),),
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
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 30*(size.height/Enviroment.height),),
            CircleAvatar(
              backgroundColor: Colors.red[500] ,
              radius: 100*(size.height/Enviroment.height),
              child: Text(nameController.text.substring(0,1).toUpperCase(),
                          style: TextStyle(fontSize: 90*(size.height/Enviroment.height))),
            ),
            SizedBox(height: 40*(size.height/Enviroment.height),),
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