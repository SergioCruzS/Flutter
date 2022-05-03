import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:infopelis/models/models.dart';
import 'package:infopelis/services/favorite_service.dart';
import 'package:provider/provider.dart';


/*
   Widget del swiper de películas
*/

class MovieSwiper extends StatelessWidget {

  final List<Movie> movies;

  const MovieSwiper({
    Key? key, 
    required this.movies
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(this.movies.length == 0){
      return Container(
        width: double.infinity,
        height: size.height*0.6,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.6,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.5,
        itemBuilder: (_, int index) {

          final movie = movies[index];
          movie.heroId = 'swiper-${movie.id}';

          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              onTap: ()async{
                bool resp = await Provider.of<FavoriteService>(context,listen: false).findMovieinDB(movie.id.toString());
                if (resp) {
                  FavoriteService.favorite = true;
                  Navigator.pushNamed(context, 'details',arguments: movie);
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
                        width: 130,
                        height: 190,
                        fit: BoxFit.cover,
                    ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
