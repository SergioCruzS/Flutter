// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:infopelis/models/user.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));


class LoginResponse {
    LoginResponse({
        required this.ok,
        required this.userDb,
        required this.token,
    });

    bool ok;
    User userDb;
    String token;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        userDb: User.fromJson(json["userDB"]),
        token: json["token"],
    );
}

