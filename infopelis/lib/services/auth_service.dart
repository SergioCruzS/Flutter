import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infopelis/global/enviroment.dart';
import 'package:infopelis/models/login_response.dart';
import 'package:infopelis/models/user.dart';

class AuthService with ChangeNotifier{

  late User user;
  bool _accessing = false;

  bool get accessing => this._accessing;

  set accessing(bool value){
    this._accessing = value;
    notifyListeners();
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

      return true;
    }else{
      return false;
    }


  }

}