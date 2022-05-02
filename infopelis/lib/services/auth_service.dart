import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:infopelis/global/enviroment.dart';
import 'package:infopelis/models/login_response.dart';
import 'package:infopelis/models/user.dart';

class AuthService with ChangeNotifier{

  late User user;
  bool _accessing = false;

  // Crear storage
  final _storage = new FlutterSecureStorage();

  //Getter y setter del acceso
  bool get accessing => this._accessing;
  set accessing(bool value){
    this._accessing = value;
    notifyListeners();
  }

  //Getter y setter del token
  static Future getToken() async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }

  Future<bool> login( String email, String password) async {

    this.accessing = true;
    
    final data ={
      'email': email,
      'password': password
    };

    final resp = await http.post(Uri.parse('${Enviroment.apiUrl}/login'),
       body: jsonEncode(data),
       headers: {
         'Content-Type': 'application/json'
       }
    );


    this.accessing = false;
    
    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.userDb;

      await this._saveToken(loginResponse.token);

      return true;
    }else{
      return false;
    }


  }

  Future _saveToken( String token ) async{
    return await _storage.write(key: 'token', value: token);
  }
  
  Future logout() async{
    //Delete token
    await _storage.delete(key: 'token');
  }

}