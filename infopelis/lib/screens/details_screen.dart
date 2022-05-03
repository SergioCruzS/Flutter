import 'package:flutter/material.dart';
import 'package:infopelis/models/models.dart';
import 'package:infopelis/services/auth_service.dart';
import 'package:infopelis/services/favorite_service.dart';
import 'package:infopelis/video/video_delegate.dart';
import 'package:infopelis/widgets/widgets.dart';
import 'package:provider/provider.dart';

/* 
   Widget de la pantalla de Detalles de la película
*/

bool logged = false;

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomAppBar(movie),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                   _PosterAndTitle(movie),
                   _Overview(movie),
                   CastingCards(movie.id),
                   listVideosMovies(movie.id)
                ]
              )
            )
          ],
        ),
      );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Color.fromARGB(255, 8, 48, 227),
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 15),
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 18),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatefulWidget {
  final Movie movie;

  const _PosterAndTitle(this.movie);

  @override
  State<_PosterAndTitle> createState() => _PosterAndTitleState(this.movie);
}

class _PosterAndTitleState extends State<_PosterAndTitle> {
  final Movie movie;

  _PosterAndTitleState(this.movie);
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: widget.movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [ 
                  FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(widget.movie.fullPosterImage),
                    height: 200,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (AuthService.data.isNotEmpty) {
                        FavoriteService.favorite = !FavoriteService.favorite;
                        if (FavoriteService.favorite) {
                          final favService = Provider.of<FavoriteService>(context,listen: false);
                          await favService.register(
                            movie.id.toString(), 
                            movie.title, 
                            movie.originalTitle, 
                            movie.posterPath!, 
                            movie.voteAverage.toString(), 
                            AuthService.data['uid']
                          );
                        } else {
                          final favService = Provider.of<FavoriteService>(context,listen: false);
                          bool respDelete = await favService.deleteMovieinDB(movie.id.toString());
                          if (respDelete) {
                            FavoriteService.favorite = false;
                          }
                        }
                      }
                      
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 80,top: 5),
                      height: 40,
                      width: 40,
                      child: FavoriteService.favorite ? Icon(Icons.star,color: Colors.yellow[900],size: 50,) : Icon(Icons.star_outline,color: Color.fromARGB(255, 193, 190, 190), size: 50),                    
                    ),
                  )
                ]
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 150,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title,
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  widget.movie.originalTitle,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_outline,
                      size: 15,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 5),
                    Text(
                      widget.movie.voteAverage.toString(),
                      style: textTheme.caption,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Text(
                  movie.overview,
                   textAlign: TextAlign.justify,
                   style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
