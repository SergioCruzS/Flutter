import 'package:flutter/material.dart';
import 'package:infopelis/global/enviroment.dart';
import 'package:infopelis/services/auth_service.dart';
import 'package:infopelis/widgets/alert_dialog.dart';
import 'package:infopelis/widgets/customTextField.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(218, 255, 255, 255),
        appBar: AppBar(
          title: Text('Registrate'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 8, 48, 227),
        ),
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
    final size = MediaQuery.of(context).size;
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
          Container(
            width: 300*(size.width/Enviroment.width),
            child: ElevatedButton(
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
              child: Text('Registrarse'),
              style: ElevatedButton.styleFrom(
                 primary: Colors.orange[400],  
                 minimumSize: Size(300*(size.width/Enviroment.width), 50*(size.height/Enviroment.height))               
              ),
            ),
          ),
          SizedBox(height: 40*(size.height/Enviroment.height),),
          Container(
             width: 300*(size.width/Enviroment.width),
             child: ElevatedButton(
               onPressed: (){Navigator.pushReplacementNamed(context, 'login');}, 
               child: Text(
                 'Ya tengo cuenta. \n\n  Iniciar sesión',
                 style: TextStyle(
                   color: Colors.black45
                 ),
               ),
               style: ElevatedButton.styleFrom(
                 primary: Colors.transparent,
                 shadowColor: Colors.transparent,  
                 minimumSize: Size(300*(size.width/Enviroment.width), 50*(size.height/Enviroment.height))               
               ),
             ),
          )

         ],
       ),    
    );
  }
}