import 'package:flutter/material.dart';

import '/theme/app_theme.dart';
import '/routes/app_routes.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  
  const MyApp({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: AppTheme.lightTheme
    );
  }
}