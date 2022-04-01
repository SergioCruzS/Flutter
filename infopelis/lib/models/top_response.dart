// To parse this JSON data, do
//
//     final popularResponse = popularResponseFromMap(jsonString);

import 'dart:convert';

import 'package:infopelis/models/models.dart';

/*
  Español:
  Clase para obtener la lista de películas mejor calificadas

  English
  Class to get the list of movies top
*/

class TopResponse {
    TopResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory TopResponse.fromJson(String str) => TopResponse.fromMap(json.decode(str));

    factory TopResponse.fromMap(Map<String, dynamic> json) => TopResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}
