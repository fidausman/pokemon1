import 'package:app/modules/loginpage/login.dart';
import 'package:flutter/material.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:app/modules/items/items_page.dart';

abstract class Router {
  static String login = "/";
  static String items = "/items";

  static Map<String, WidgetBuilder> getRoutes(context) {
    return {
      login: (context) => LoginPage(),
      items: (context) => ItemsPage(),
    };
  }
}
