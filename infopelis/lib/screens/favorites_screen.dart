import 'package:flutter/material.dart';
import 'package:infopelis/models/favmovie.dart';
import 'package:infopelis/models/models.dart';
import 'package:infopelis/providers/movies_provider.dart';
import 'package:infopelis/services/favorite_service.dart';
import 'package:provider/provider.dart';

class FavoritesMovies extends StatefulWidget {
  @override
  State<FavoritesMovies> createState() => _FavoritesMoviesState();
}

class _FavoritesMoviesState extends State<FavoritesMovies> {
  @override
  Widget build(BuildContext context) {
    final fmov = Provider.of<FavoriteService>(context);
    List<FavMovie> listMovies =[];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Películas Favoritas'),
          centerTitle: true,       
        ),
        body:  Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: fmov.listFavorites(),
                builder: (context, snapshot) {
                  listMovies = fmov.movies;
                  return ListView.builder(
                  itemCount: listMovies.length,
                  itemBuilder: (context, int index) => _movieTile(context,listMovies[index])
                  );
                }
              ),
            )
          ],
        ),        
      ),
    );
  }
}

Widget _movieTile(BuildContext context, FavMovie mov){
    return Dismissible(
      key: Key(mov.title),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) async {
        final favService = Provider.of<FavoriteService>(context,listen: false);
        bool respDelete = await favService.deleteMovieinDB(mov.id.toString());
        if (respDelete) {
          FavoriteService.favorite = false;
        }
      },
      background: Container(
        color: Colors.redAccent,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Eliminar',style: TextStyle(color: Colors.white),),
        ),
      ),
      child: ListTile(
            leading: CircleAvatar(
              child: Image(image: NetworkImage(mov.fullPosterImage)),
              backgroundColor: Colors.white,
            ),
            title: Text(mov.title),
            trailing: Icon(Icons.arrow_right_outlined),
            onTap: () async {
              Movie movie = await Provider.of<MoviesProvider>(context, listen: false).getMoviebyID(int.parse(mov.id));
              movie.heroId = 'fav-${movie.id}';             
              FavoriteService.favorite = true; 
              Navigator.pushNamed(context, 'details',arguments: movie);              
            },
      ),
    );
}