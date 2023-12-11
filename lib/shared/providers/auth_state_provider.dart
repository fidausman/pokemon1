// import 'package:app/shared/widgets/loading_spinner_modal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _authenticated = false;
  late String _email;

  String get email => _email;
  bool get isAuthenticated => _authenticated;

  getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString('email')!;

    _email = email;
    notifyListeners();
  }

  setUserInfo(String value) {
    _email = value;
    notifyListeners();
  }

  logout(context) async {
    setAuthenticated(false);
    // showLoadingSpinnerModal(context, 'Logging out');
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    prefs.remove('refreshToken');
    prefs.remove('email');
    prefs.remove('password');
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/');
  }

  void setAuthenticated(bool value) {
    _authenticated = value;
    notifyListeners();
  }
}
