// To parse this JSON data, do
//
//     final jwtToken = jwtTokenFromJson(jsonString);

import 'dart:convert';

JwtToken jwtTokenFromJson(String str) => JwtToken.fromJson(json.decode(str));

String jwtTokenToJson(JwtToken data) => json.encode(data.toJson());

class JwtToken {
  String access;
  String refresh;

  JwtToken({
    required this.access,
    required this.refresh,
  });

  factory JwtToken.fromJson(Map<String, dynamic> json) => JwtToken(
        access: json["access"],
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
      };
}
