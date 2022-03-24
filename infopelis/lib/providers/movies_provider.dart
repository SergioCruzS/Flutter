import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:infopelis/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'f9beb98e61d3dd537bff3381c028e8c2';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _nowPlaying = '3/movie/now_playing';

  List<Movie> onDisplayMovies = [];

  MoviesProvider() {
    print('MoviesProvider inicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, _nowPlaying,
        {'api_key': _apiKey, 
         'language': _language, 
        'page': '1'
        }
    );

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    print(nowPlayingResponse.results[1].title);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners(); //notifica a los widgets para que redibuje si surge cambio en la data
    
  }
}
