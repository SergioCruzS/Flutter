// To parse this JSON data, do
//
//     final videoMovieResponse = videoMovieResponseFromMap(jsonString);

import 'dart:convert';

import 'package:infopelis/models/models.dart';

class VideoMovieResponse {
    VideoMovieResponse({
        required this.id,
        required this.results,
    });

    int id;
    List<VideoMovie> results;

    factory VideoMovieResponse.fromJson(String str) => VideoMovieResponse.fromMap(json.decode(str));

    factory VideoMovieResponse.fromMap(Map<String, dynamic> json) => VideoMovieResponse(
        id: json["id"],
        results: List<VideoMovie>.from(json["results"].map((x) => VideoMovie.fromMap(x))),
    );
}


