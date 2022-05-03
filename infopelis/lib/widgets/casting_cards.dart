import 'package:flutter/material.dart';
import 'package:infopelis/global/enviroment.dart';
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
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (_,AsyncSnapshot<List<Cast>> snapshot){
          if (!snapshot.hasData) {
            return Container(
              height: 180,
              child: Center(child: Container(height: 30*(size.height/Enviroment.height),
                                             width: 30*(size.width/Enviroment.width),
                                            child: CircularProgressIndicator()
              )),
            );
          }

          final List<Cast> cast = snapshot.data!;

          return Container(
              margin: EdgeInsets.only(bottom: 30),
              width: double.infinity,
              height: 180*(size.height/Enviroment.height),
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
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110*(size.width/Enviroment.width),
      height: 100*(size.height/Enviroment.height),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage(actor.fullProfilePathImage),
              height: 130*(size.height/Enviroment.height),
              width: 100*(size.width/Enviroment.width),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5*(size.height/Enviroment.height)),
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
