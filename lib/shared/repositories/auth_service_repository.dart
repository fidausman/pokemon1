import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final _dio = Dio();
  Dio getDioInstance() => _dio;

  Future<bool> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        '${ApiConstants.ngrokUrl}/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 201) {
        final accessToken = response.data['accessToken'];
        final refreshToken = response.data['refreshToken'];

        print('AccessToken: $accessToken');
        print('RefreshToken: $refreshToken');

        // Save tokens to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('accessToken', accessToken);
        prefs.setString('refreshToken', refreshToken);
        prefs.setString('email', email);
        prefs.setString('password', password);
        return true;
      } else if (response.statusCode == 404) {
        return false;
      }
      return false;
    } catch (error) {
      if (error is DioException) return false;
      throw Exception(error);
    }
  }

  Future<void> requestNewAccessToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');

      Response response = await _dio.post(
        '${ApiConstants.ngrokUrl}/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      final newAccessToken = response.data['accessToken'];
      print('New access token: $newAccessToken');

      // Update the access token in SharedPreferences
      prefs.setString('accessToken', newAccessToken);
    } catch (error) {
      print('Access token could not be re-generated $error');
      rethrow;
    }
  }

  Future<void> regenerateToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');

      if (refreshToken != null) {
        await requestNewAccessToken();

        print('Token regenerated successfully');
      } else {
        // Handle the case where refreshToken is null (user is not logged in or no refresh token available)
        print('No refresh token available. User needs to log in.');
      }
    } catch (error) {
      // Handle error during token regeneration
      print('Token regeneration failed: $error');
      rethrow;
    }
  }

  Future<bool> signup({
    required String username,
    required String email,
    required int phoneNumber,
    required String password,
  }) async {
    print('$username $email $phoneNumber $password');

    final uri = '${ApiConstants.ngrokUrl}/auth/register';
    try {
      final Response response = await _dio.post(uri, data: {
        'username': username,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Failed ot signup: $e');
    }
  }
}
