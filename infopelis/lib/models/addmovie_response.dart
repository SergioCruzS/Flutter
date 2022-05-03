// To parse this JSON data, do
//
//     final addMovieResponse = addMovieResponseFromJson(jsonString);

import 'dart:convert';

AddMovieResponse addMovieResponseFromJson(String str) => AddMovieResponse.fromJson(json.decode(str));

String addMovieResponseToJson(AddMovieResponse data) => json.encode(data.toJson());

class AddMovieResponse {
    AddMovieResponse({
        required this.ok,
        required this.newMovie,
    });

    bool ok;
    NewMovie newMovie;

    factory AddMovieResponse.fromJson(Map<String, dynamic> json) => AddMovieResponse(
        ok: json["ok"],
        newMovie: NewMovie.fromJson(json["newMovie"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "newMovie": newMovie.toJson(),
    };
}

class NewMovie {
    NewMovie({
        required this.id,
        this.title,
        this.originalTitle,
        this.posterPath,
        this.voteAverage,
        required this.uid,
    });

    String id;
    String? title;
    String? originalTitle;
    String? posterPath;
    String? voteAverage;
    String uid;

    factory NewMovie.fromJson(Map<String, dynamic> json) => NewMovie(
        id: json["id"],
        title: json["title"],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "uid": uid,
    };
}
