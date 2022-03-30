// To parse this JSON data, do
//
//     final actorsResponse = actorsResponseFromMap(jsonString);

import 'dart:convert';

import 'package:infopelis/models/models.dart';

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

