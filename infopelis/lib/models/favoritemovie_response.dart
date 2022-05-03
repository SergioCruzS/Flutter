// To parse this JSON data, do
//
//     final favoriteMovieResponse = favoriteMovieResponseFromJson(jsonString);

import 'dart:convert';

import 'package:infopelis/models/favmovie.dart';

FavoriteMovieResponse favoriteMovieResponseFromJson(String str) => FavoriteMovieResponse.fromJson(json.decode(str));

String favoriteMovieResponseToJson(FavoriteMovieResponse data) => json.encode(data.toJson());

class FavoriteMovieResponse {
    FavoriteMovieResponse({
        required this.ok,
        required this.uid,
        required this.movies,
    });

    bool ok;
    String uid;
    List<FavMovie> movies;

    factory FavoriteMovieResponse.fromJson(Map<String, dynamic> json) => FavoriteMovieResponse(
        ok: json["ok"],
        uid: json["uid"],
        movies: List<FavMovie>.from(json["movies"].map((x) => FavMovie.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "uid": uid,
        "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
    };
}
