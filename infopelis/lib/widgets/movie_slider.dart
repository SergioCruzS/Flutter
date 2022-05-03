import 'package:flutter/material.dart';
import 'package:infopelis/global/enviroment.dart';
import 'package:infopelis/services/auth_service.dart';
import 'package:infopelis/services/favorite_service.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

/*
   Widget del slider de películas
*/

class MovieSlider extends StatelessWidget {

  final List<Movie> movies;
  final String title;

  const MovieSlider({
    required this.movies,
    required this.title
  }
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 350*(size.height/Enviroment.height),
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (_, int index) =>_MoviePoster(movies[index],title)
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;
  final String sectionTitle;
  const _MoviePoster(this.movie, this.sectionTitle);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    movie.heroId = 'slider${sectionTitle.trim()}-${movie.id}';
    return Container(
      width: 120*(size.width/Enviroment.width),
      height: 190*(size.height/Enviroment.height),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: ()async{
                if (AuthService.data.isNotEmpty) {
                  bool resp = await Provider.of<FavoriteService>(context,listen: false).findMovieinDB(movie.id.toString());
                  if (resp) {
                    FavoriteService.favorite = true;
                    Navigator.pushNamed(context, 'details',arguments: movie);
                  }else{
                    FavoriteService.favorite = false;
                    Navigator.pushNamed(context, 'details',arguments: movie);
                  }
                }else{
                  FavoriteService.favorite = false;
                  Navigator.pushNamed(context, 'details',arguments: movie);
                }
            },
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImage),
                  width: 130*(size.width/Enviroment.width),
                  height: 190*(size.height/Enviroment.height),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10*(size.height/Enviroment.height)),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
