import 'package:flutter/material.dart';
import 'package:infopelis/services/auth_service.dart';
import 'package:infopelis/widgets/alert_dialog.dart';
import 'package:infopelis/widgets/customTextField.dart';
import 'package:provider/provider.dart';

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
    final authService = Provider.of<AuthService>(context);
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
             textController: emailController,
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
            onPressed: authService.accessing ? null : () async {
              if (passwordController.text == repeatPasswordController.text) {
                FocusScope.of(context).unfocus();
                final registerOk = await authService.register(nameController.text,emailController.text.trim(), passwordController.text);
  
                if (registerOk) {
                  Navigator.pushReplacementNamed(context, 'home');
                }else{
                  showAlertDialog(context, 'Error al registrarse', 'Revise que sus datos sean correctos');
                }
              } else {
                showAlertDialog(context, '¡Error!', 'Las contraseñas ingresadas no coinciden');
              }
              
            }, 
            child: Text('Registrarse')
          )

         ],
       ),    
    );
  }
}