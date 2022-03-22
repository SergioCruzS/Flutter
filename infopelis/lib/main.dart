import 'package:flutter/material.dart';
import 'package:infopelis/screens/details_screen.dart';
import 'package:infopelis/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       title: 'Peliculas',
       initialRoute: 'home',
       routes: {
         'home': (_) => HomeScreen(),
         'details':(_) => DetailsScreen()
       },
    );
  }
}
