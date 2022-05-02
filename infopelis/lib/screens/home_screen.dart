import 'package:flutter/material.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<SocketService>(context);

    return Scaffold(
      //backgroundColor: Color.fromARGB(218, 0, 0, 0),
      appBar: AppBar(
        title: const Text('Películas en cines',style: TextStyle(fontFamily: 'Bebas',fontSize: 36),),
        elevation: 10,
        actions: [
          IconButton(
            iconSize: 36,
            color: Color.fromARGB(255, 28, 206, 222),
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
            const SizedBox(height: 15,),
            MovieSlider(movies: moviesProvider.popularMovies, title: 'Populares'),
            const SizedBox(height: 15,),
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