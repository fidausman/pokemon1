import 'package:app/modules/login/login_page.dart';
import 'package:app/modules/otp/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:app/modules/items/items_page.dart';

abstract class Router {
  static String login = "/login";
  static String home = "/home";
  static String items = "/items";
  static String otp = "/otp";

  static Map<String, WidgetBuilder> getRoutes(context) {
    return {
      home: (context) => HomePage(),
      login: (context) => LoginPage(),
      items: (context) => ItemsPage(),
      otp: (context) => OtpScreen(),
    };
  }
}
