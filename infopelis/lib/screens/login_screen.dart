import 'package:flutter/material.dart';
import 'package:infopelis/screens/home_screen.dart';
import 'package:infopelis/widgets/customTextField.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top:100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _Logo(),
              SizedBox(height: 30,),
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
      return Container(
        width: 250,
        child: Center(
          child: Column(
            children: <Widget>[
                Image(image: AssetImage('assets/loading.gif')),
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
          ElevatedButton(onPressed: (){}, child: Text('Iniciar Sesión'))
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
           Text('¿No tienes cuenta?'),
           SizedBox(height: 10,),
           ElevatedButton(onPressed: (){Navigator.pushNamed(context, 'home');}, child: Text('Registrate ahora'))
        ],
      ),
    );
  }
}