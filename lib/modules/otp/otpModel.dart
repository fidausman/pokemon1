// To parse this JSON data, do
//
//     final otp = otpFromJson(jsonString);

import 'dart:convert';

Otp otpFromJson(String str) => Otp.fromJson(json.decode(str));

String otpToJson(Otp data) => json.encode(data.toJson());

class Otp {
  String secret;
  String otp;

  Otp({
    required this.secret,
    required this.otp,
  });

  factory Otp.fromJson(Map<String, dynamic> json) => Otp(
        secret: json["secret"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "secret": secret,
        "otp": otp,
      };
}
