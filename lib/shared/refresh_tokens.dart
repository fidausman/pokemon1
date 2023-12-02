import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String refreshTokenKey = 'refreshToken';

  // Store refresh token
  static Future<void> saveRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(refreshTokenKey, refreshToken);
  }

  // Retrieve refresh token
  static Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshTokenKey);
  }

  // Delete refresh token
  static Future<void> deleteRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(refreshTokenKey);
  }
}
