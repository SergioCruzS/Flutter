import 'package:flutter/material.dart';
import 'package:infopelis/models/models.dart';
import 'package:infopelis/providers/movies_provider.dart';
import 'package:provider/provider.dart';

/*
  Widget de carta para los actores
*/

class CastingCards extends StatelessWidget {
   
  final int movieId;
  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (_,AsyncSnapshot<List<Cast>> snapshot){
          if (!snapshot.hasData) {
            return Container(
              height: 180,
              child: Center(child: Container(height: 30,width: 30,child: CircularProgressIndicator())),
            );
          }

          final List<Cast> cast = snapshot.data!;

          return Container(
              margin: EdgeInsets.only(bottom: 30),
              width: double.infinity,
              height: 180,
              child: ListView.builder(
                  itemCount: cast.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, int index) => _CastCard(cast[index])
              ),
          );
        },
    );

    
  }
}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard(this.actor);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage(actor.fullProfilePathImage),
              height: 130,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
