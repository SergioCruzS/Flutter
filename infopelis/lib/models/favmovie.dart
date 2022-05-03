class FavMovie {
    FavMovie({
        required this.id,
        required this.title,
        required this.originalTitle,
        required this.posterPath,
        required this.voteAverage,
        required this.uid,
    });

    String id;
    String title;
    String originalTitle;
    String posterPath;
    String voteAverage;
    String uid;

    get fullPosterImage{
      if (this.posterPath != null ) 
        return 'https://image.tmdb.org/t/p/w500${this.posterPath}';
      else
        return 'https://timescineplex.com/times/img/no-poster.png';
    }

    factory FavMovie.fromJson(Map<String, dynamic> json) => FavMovie(
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