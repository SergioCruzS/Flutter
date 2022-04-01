import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:infopelis/helpers/debouncer.dart';
import 'package:infopelis/models/actors_response.dart';
import 'package:infopelis/models/models.dart';
import 'package:infopelis/models/searchMovies_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'f9beb98e61d3dd537bff3381c028e8c2';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-MX';
  String _nowPlaying = '3/movie/now_playing';
  String _popular = '3/movie/popular';
  String _topRated = '3/movie/top_rated';
  String _credits = '3/movie/';
  String _searchMovie = '3/search/movie';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topMovies = [];

  Map<int,List<Cast>> moviesCast= {};
  Map<int,List<VideoMovie>> moviesVideo= {};
  List<Movie> moviesSuggest= [];

  final StreamController<List<Movie>> _suggestionsSreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionsSreamController.stream;
  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
    
  );

  //Constructor de MoviesProvider()
  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getTopRatedMovies();
  }

  //Obtención de películas en cines
  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, _nowPlaying,
        {'api_key': _apiKey, 
         'language': _language, 
        'page': '1'
        }
    );

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners(); //notifica a los widgets para que redibuje si surge cambio en la data
    
  }

  //Obtención de películas populares
  getPopularMovies() async {
    var url = Uri.https(_baseUrl, _popular,
        {
          'api_key': _apiKey, 
          'language': _language, 
          'page': '1'
        }
    );

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    popularMovies = [...popularMovies,...popularResponse.results];
    notifyListeners(); //notifica a los widgets para que redibuje si surge cambio en la data
  }

  //Obtención de películas populares
  getTopRatedMovies() async {
    var url = Uri.https(_baseUrl, _topRated,
        {
          'api_key': _apiKey, 
          'language': _language, 
          'page': '1'
        }
    );

    final response = await http.get(url);
    final topResponse = TopResponse.fromJson(response.body);
    topMovies = [...topMovies,...topResponse.results];
    notifyListeners(); //notifica a los widgets para que redibuje si surge cambio en la data
  }

  //Obtención de actores de la película
  Future <List<Cast>> getMovieCast(int movieId)async{
    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    var url = Uri.https(_baseUrl, '${_credits}$movieId/credits',
        {
          'api_key': _apiKey, 
          'language': _language,
        },
    );
    final response = await http.get(url);
    final actorsResponse = ActorsResponse.fromJson(response.body);
    
    moviesCast[movieId] = actorsResponse.cast;
    return actorsResponse.cast;
  }

  //Obtención de los resultados de búsqueda
  Future<List<Movie>> searchMovies (String query) async {
  //  if(moviesSuggest.containsKey(query)) return moviesSuggest[query]!;
     final url = Uri.https(_baseUrl, _searchMovie,
        {
          'api_key': _apiKey, 
          'language': _language,
          'query': query
        },
    );
    final response = await http.get(url);
    final searchResponse = SearchMovieResponse.fromJson(response.body);
    moviesSuggest = searchResponse.results;
    return searchResponse.results;
  }
  
  //Retorno de resultados
  searchResults() => this.moviesSuggest;

  //Obtención de sugerencias de películas según la búsqueda
  void getSuggestionsByQuery(String searchQuery){
      debouncer.value='';
      debouncer.onValue=(value)async{
        final results = await this.searchMovies(value);
        this._suggestionsSreamController.add(results);
      };
      final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
        debouncer.value = searchQuery;
      });

      Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

  //Obtención de los videos o trailers de la película
  
  Future <List<VideoMovie>> getMovieVideo(int movieId)async{
    if(moviesVideo.containsKey(movieId)) return moviesVideo[movieId]!;
    var url = Uri.https(_baseUrl, '3/movie/$movieId/videos',
        {
          'api_key': _apiKey, 
          'language': 'us-US',
        },
    );
    final response = await http.get(url);
    final videoResponse = VideoMovieResponse.fromJson(response.body);
    
    moviesVideo[movieId] = videoResponse.results;
    return videoResponse.results;
  }

}
