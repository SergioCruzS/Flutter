import 'package:demostraicion_flutter_hdds/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '/theme/app_theme.dart';


class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final menuOptions = AppRoutes.menuOptions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Demostración de Flutter'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, i ) => ListTile(
          leading: Icon( menuOptions[i].icon, color: AppTheme.primary ),
          title: Text( menuOptions[i].name ),
          onTap: () {
            Navigator.pushNamed(context, menuOptions[i].route);
          },
        ), 
        separatorBuilder: ( _, __ ) => const Divider(), 
        itemCount: menuOptions.length
      )
    );
  }
}