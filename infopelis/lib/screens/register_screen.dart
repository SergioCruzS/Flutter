import 'package:flutter/material.dart';
import 'package:infopelis/widgets/customTextField.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Registrate'),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _Form()
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
       child: Column(
         children: <Widget>[
           CustomTextField(
             icon: Icons.account_circle, 
             placeholder: 'Ingresa tu nombre', 
             textController: nameController
          ),
           CustomTextField(
             icon: Icons.mail_outline, 
             placeholder: 'Correo electrónico', 
             textController: nameController,
             keyboardType: TextInputType.emailAddress,
          ),
          CustomTextField(
             icon: Icons.lock, 
             placeholder: 'Ingresa una contraseña', 
             textController: passwordController,
             isPassword: true,
          ),
          CustomTextField(
             icon: Icons.lock, 
             placeholder: 'Repite tu contraseña', 
             textController: repeatPasswordController,
             isPassword: true,
          ),
          ElevatedButton(
            onPressed: (){}, 
            child: Text('Registrarse')
          )

         ],
       ),    
    );
  }
}