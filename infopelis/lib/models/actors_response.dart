// To parse this JSON data, do
//
//     final actorsResponse = actorsResponseFromMap(jsonString);

import 'dart:convert';
import 'package:infopelis/models/models.dart';

/*
  Español:
  Clase para obtener la lista de actores y del equipo de producción de la película

  English
  Class to get the list of actors and the production team of the movie
*/

class ActorsResponse {
    ActorsResponse({
        this.id,
        required this.cast,
        required this.crew,
    });

    int? id;
    List<Cast> cast;
    List<Cast> crew;

    factory ActorsResponse.fromJson(String str) => ActorsResponse.fromMap(json.decode(str));

    factory ActorsResponse.fromMap(Map<String, dynamic> json) => ActorsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
    );
}

