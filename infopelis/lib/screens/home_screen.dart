import 'package:flutter/material.dart';
import 'package:infopelis/providers/movies_provider.dart';
import 'package:infopelis/search/search_delegate.dart';
import 'package:infopelis/widgets/movie_swiper.dart';
import 'package:infopelis/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

/*
   Pantalla principal de la aplicación
*/

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        elevation: 0,
        actions: [
          IconButton(
             icon: Icon(Icons.search),
             onPressed: ()=> showSearch(context: context, delegate: MovieSearchDelegate()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieSwiper(movies: moviesProvider.onDisplayMovies),
            SizedBox(height: 15,),
            MovieSlider(movies: moviesProvider.popularMovies, title: 'Populares'),
            SizedBox(height: 15,),
            MovieSlider(movies: moviesProvider.topMovies, title: 'Mejor Calificadas'),
          ],
        ),
      ),
    );
  }
}