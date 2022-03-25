import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infopelis/providers/movies_provider.dart';
import 'package:infopelis/screens/details_screen.dart';
import 'package:infopelis/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),lazy: false,
        )
      ],
      child: MyApp(),
    );
  }
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
        'details': (_) => DetailsScreen()
      },
    );
  }
}
