import 'package:flutter/material.dart';
import 'package:infopelis/global/enviroment.dart';
import 'package:infopelis/screens/home_screen.dart';
import 'package:infopelis/services/auth_service.dart';
import 'package:infopelis/widgets/alert_dialog.dart';
import 'package:infopelis/widgets/customTextField.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Iniciar Sesión'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 8, 48, 227),
        ),
        backgroundColor: Color.fromARGB(218, 255, 255, 255),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top:100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _Logo(),
              SizedBox(height: 30*(size.height/Enviroment.height),),
              _Form(),
              _Labels(),
            ],
          ),
        ),
      ),
    );
  }

}

class _Logo extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
      return Container(
        width: 250*(size.width/Enviroment.width),
        child: Center(
          child: Column(
            children: <Widget>[
                //Image(image: AssetImage('assets/loading.gif')),
            ],
          ),
        ),
      );
    }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
   
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomTextField(
            icon: Icons.mail_outline,
            placeholder: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomTextField(
            icon: Icons.lock,
            placeholder: 'Contraseña',
            keyboardType: TextInputType.visiblePassword,
            textController: passwordController,
            isPassword: true,
          ),
          //Container(
          //  width: 300*(size.width/Enviroment.width),
          //  child: ElevatedButton(
          //    onPressed: (){Navigator.pushNamed(context, 'register');}, 
          //    child: Text(
          //      '¿Olvidaste tu contraseña?',
          //      style: TextStyle(color: Colors.black45),                     
          //    ),
          //    style: ElevatedButton.styleFrom(
          //      primary: Colors.transparent,
          //      shadowColor: Colors.transparent,  
          //      minimumSize: Size(300*(size.width/Enviroment.width), 50*(size.height/Enviroment.height))               
          //    ),
          //  ),
          //),
          SizedBox(height: 20*(size.height/Enviroment.height),),
          Container(
            width: 300*(size.width/Enviroment.width),
            child: ElevatedButton(
              onPressed: authService.accessing ? null : () async {
                FocusScope.of(context).unfocus();
                final loginOk = await authService.login(emailController.text.trim(), passwordController.text);
          
                if (loginOk) {
                  Navigator.pushReplacementNamed(context, 'home');
                }else{
                  showAlertDialog(context, 'Error al iniciar sesión', 'Revise que sus datos sean correctos');
                }
              }, 
              child: Text('Iniciar Sesión'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size(300*(size.width/Enviroment.width), 50*(size.height/Enviroment.height))
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
           SizedBox(height: 60*(size.height/Enviroment.height),),
           Text('¿No tienes cuenta?',
                style: TextStyle(fontSize: 16,color: Colors.black45),
           ),
           SizedBox(height: 30*(size.height/Enviroment.height),),
           Container(
             width: 300*(size.width/Enviroment.width),
             child: ElevatedButton(
               onPressed: (){Navigator.pushNamed(context, 'register');}, 
               child: Text('Registrate ahora'),
               style: ElevatedButton.styleFrom(
                 primary: Colors.orange[400],  
                 minimumSize: Size(300*(size.width/Enviroment.width), 50*(size.height/Enviroment.height))               
               ),
             ),
           )
        ],
      ),
    );
  }
}