import 'dart:convert';


 /*
  Español:
  Clase para crear el objeto película

  English
  Class to create movie object
*/

class Movie {
    Movie({
        required this.adult,
        this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        this.posterPath,
        this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    bool adult;
    String? backdropPath;
    List<int> genreIds;
    int id;
    String originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    String? posterPath;
    String? releaseDate;
    String title;
    bool video;
    double voteAverage;
    int voteCount;
    
    /*
      Español:
      heroId es el identificador para la animación

      English:
      heroId is the identifier for the animation
    */
    String? heroId;

    /*
      Español:
      fullPosterImage obtiene el poster de la película, en caso de no tener poster regresa otra imagen

      English:
      fullPosterImage obtains the movie poster, in case of not having a poster it returns another image
    */
    get fullPosterImage{
      if (this.posterPath != null ) 
        return 'https://image.tmdb.org/t/p/w500${this.posterPath}';
      else
        return 'https://timescineplex.com/times/img/no-poster.png';
    }

    /*
      Español:
      fullBackdropPath obtiene el fondo de la película, en caso de no tener poster regresa otra imagen

      English:
      fullBackdropPath obtains the movie Backdrop, in case of not having a poster it returns another image
    */
    
    get fullBackdropPath{
      if (this.backdropPath != null ) 
        return 'https://image.tmdb.org/t/p/w500${this.backdropPath}';
      else
        return 'https://timescineplex.com/times/img/no-poster.png';
    }

    factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

    factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );
}

