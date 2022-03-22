import 'package:flutter/material.dart';
import 'package:infopelis/widgets/card_swiper.dart';
import 'package:infopelis/widgets/movie_slider.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(),
            SizedBox(height: 15,),
            MovieSlider(),
          ],
        ),
      ),
    );
  }
}