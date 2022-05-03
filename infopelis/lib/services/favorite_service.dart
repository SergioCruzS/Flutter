import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:infopelis/global/enviroment.dart';
import 'package:infopelis/models/addmovie_response.dart';
import 'package:infopelis/models/favmovie.dart';
import 'package:infopelis/models/favoritemovie_response.dart';
import 'package:infopelis/services/auth_service.dart';
import 'package:http/http.dart' as http;

class FavoriteService with ChangeNotifier{

  List<FavMovie> movies = [];
  static bool favorite = false;

  Future<bool> register( String id, String title, String original_title, String poster_path, String voteAverage, String uid) async {
    
    //this.accessing = true;

    final data ={
      "id": id,
      "title": title,
      "original_title": original_title,
      "poster_path": poster_path,
      "vote_average": voteAverage,
      "uid": uid
    };

    final resp = await http.post(Uri.parse('${Enviroment.apiUrl}/movies/new'),
       body: jsonEncode(data),
       headers: {
         'Content-Type': 'application/json'
       }
    );

    //this.accessing = false;

     if ( resp.statusCode == 200 ) {
      final addmovieResponse = addMovieResponseFromJson(resp.body);
      print(addmovieResponse.ok);
      return true;
    }else{
      //final respBody = jsonDecode(resp.body);
      //return respBody['msg'];
      return false;
    }
  }


  Future listFavorites() async {
    final uid = AuthService.data['uid'];
    final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/movies/get'),
      headers: {
         'Content-Type': 'application/json',
         'x-uid': uid
      }
    );

    if ( resp.statusCode == 200 ) {
      final favMovieResponse = favoriteMovieResponseFromJson(resp.body);
      this.movies = favMovieResponse.movies;      
      return true;
    }else{
      return false;
    }
  }
  
  Future<bool> findMovieinDB(String idMovie) async {
    final uid = AuthService.data['uid'];
    final id = idMovie;
    final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/movies/get/findmovie'),
      headers: {
         'Content-Type': 'application/json',
         'x-uid': uid,
         'x-id': id
      }
    );

    if ( resp.statusCode == 200 ) {    
      return true;
    }else{
      return false;
    }
  }

  Future<bool> deleteMovieinDB(String idMovie) async {
    final uid = AuthService.data['uid'];
    final id = idMovie;
    final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/movies/get/deletemovie'),
      headers: {
         'Content-Type': 'application/json',
         'x-uid': uid,
         'x-id': id
      }
    );

    if ( resp.statusCode == 200 ) {    
      return true;
    }else{
      return false;
    }
  }
  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}