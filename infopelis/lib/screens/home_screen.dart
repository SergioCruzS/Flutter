import 'package:flutter/material.dart';
import 'package:infopelis/providers/movies_provider.dart';
import 'package:infopelis/widgets/card_swiper.dart';
import 'package:infopelis/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            SizedBox(height: 15,),
            MovieSlider(),
          ],
        ),
      ),
    );
  }
}