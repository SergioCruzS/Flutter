import 'package:flutter/material.dart';
import 'package:infopelis/helpers/portrait_mode.dart';
import 'package:infopelis/providers/movies_provider.dart';
import 'package:infopelis/screens/account_screen.dart';
import 'package:infopelis/screens/details_screen.dart';
import 'package:infopelis/screens/details_screen_favorites.dart';
import 'package:infopelis/screens/favorites_screen.dart';
import 'package:infopelis/screens/home_screen.dart';
import 'package:infopelis/screens/loading_screen.dart';
import 'package:infopelis/screens/login_screen.dart';
import 'package:infopelis/screens/register_screen.dart';
import 'package:infopelis/services/auth_service.dart';
import 'package:infopelis/services/favorite_service.dart';
import 'package:infopelis/services/socket_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget with PortraitModeMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //create: (_) => MoviesProvider(),lazy: false,
          create: (_) => SocketService(),
        ),
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteService(),
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
      initialRoute: 'loading',
      routes: {
        'home'    : (_) => HomeScreen(), 
        'details' : (_) => DetailsScreen(),
        'detailsFav' : (_) => DetailsScreenFavorites(),
        'login'   : (_) => LoginScreen(),
        'register': (_) => RegisterScreen(),
        'account' : (_) => AccountScreen(),
        'favorite': (_) => FavoritesMovies(),
        'loading': (_) => LoadingScreen()
      },
    );
  }
}
