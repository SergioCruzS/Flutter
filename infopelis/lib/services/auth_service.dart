import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:infopelis/global/enviroment.dart';
import 'package:infopelis/models/login_response.dart';
import 'package:infopelis/models/register_response.dart';
import 'package:infopelis/models/user.dart';

class AuthService with ChangeNotifier{

  late User user;
  bool _accessing = false;
  static Map<String, dynamic> data = {};

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

  Future<bool> register( String name, String email, String password) async {
    
    this.accessing = true;

    final data ={
      'name': name,
      'email': email,
      'password': password
    };

    final resp = await http.post(Uri.parse('${Enviroment.apiUrl}/login/new'),
       body: jsonEncode(data),
       headers: {
         'Content-Type': 'application/json'
       }
    );

    this.accessing = false;

     if ( resp.statusCode == 200 ) {
      final registerResponse = registerResponseFromJson(resp.body);
      this.user = registerResponse.newUser;

      await this._saveToken(registerResponse.token);

      return true;
    }else{
      //final respBody = jsonDecode(resp.body);
      //return respBody['msg'];
      return false;
    }
  }

  Future _saveToken( String token ) async{
    return await _storage.write(key: 'token', value: token);
  }
  
  Future logout() async{
    data ={};
    //Delete token
    await _storage.delete(key: 'token');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/login/renew'),
       headers: {
         'Content-Type': 'application/json',
         'x-token': token.toString()
       }
    );
    
    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.userDb;
      final respBody = jsonDecode(resp.body);
      data = respBody['userDB'];
      await this._saveToken(loginResponse.token);
      
      return true;
    }else{
      //final respBody = jsonDecode(resp.body);
      //return respBody['msg'];
      data = {};
      this.logout();
      return false;
    }
  }

}