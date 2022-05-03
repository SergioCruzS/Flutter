import 'package:flutter/material.dart';
import 'package:infopelis/global/enviroment.dart';
import 'package:infopelis/search/search_delegate.dart';
import 'package:infopelis/services/auth_service.dart';
import 'package:infopelis/widgets/movie_swiper.dart';
import 'package:infopelis/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

import '../services/socket_service.dart';

/*
   Pantalla principal de la aplicación
*/

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<SocketService>(context);
    final size = MediaQuery.of(context).size;
    checkLoginState(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(211, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Películas en cines',style: TextStyle(fontFamily: 'Bebas',fontSize: 36),),
        elevation: 10,
        actions: [
          IconButton(
            iconSize: 36,
            color: Colors.white60,
             icon: const Icon(Icons.search),
             onPressed: ()=> showSearch(context: context, delegate: MovieSearchDelegate()),
          )
        ],
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 8, 48, 227),
        leading: IconButton(
          onPressed: () async {
            final bool loginOk = await checkLoginState(context);
            if (loginOk) {
              Navigator.pushNamed(context, 'account');
            }else{
              Navigator.pushNamed(context, 'login');
            }
          }, 
          icon: Icon(Icons.account_circle)
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieSwiper(movies: moviesProvider.onDisplayMovies),
            SizedBox(height: 15*(size.height/Enviroment.height),),
            MovieSlider(movies: moviesProvider.popularMovies, title: 'Populares'),
            SizedBox(height: 15*(size.height/Enviroment.height),),
            MovieSlider(movies: moviesProvider.topMovies, title: 'Mejor Calificadas'),
          ],
        ),
      ),
    );
  }
}


Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final authenticated = authService.isLoggedIn();
    return authenticated;
}