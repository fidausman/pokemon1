import 'package:app/main.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState {
  loginFailed,
  loginSuccess,
  emailNotVerified,
  signupFailed,
}

const snackBar = SnackBar(
  content: Text('Error'),
);

class AuthService {
  AuthService._();
  static final AuthService _instance = AuthService._();
  static AuthService get instance => _instance;

  // Dio
  static final _dio = Dio();
  Dio getDioInstance() => _dio;

  Future<AuthState> login(String username, String password) async {
    try {
      Response response = await _dio.post(
        '${ApiConstants.cyclic}/auth/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 201) {
        final accessToken = response.data['accessToken'];
        final refreshToken = response.data['refreshToken'];

        print('AccessToken: $accessToken');
        print('RefreshToken: $refreshToken');

        // Save tokens to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('refreshToken', refreshToken);
        await prefs.setString('username', username);
        await prefs.setString('password', password);
        Future.delayed(const Duration(milliseconds: 100));
        return AuthState.loginSuccess;
      } else if (response.statusCode == 404) {
        return AuthState.loginFailed;
      } else if (response.statusCode == 401) {
        return AuthState.emailNotVerified;
      }
      return AuthState.loginFailed;
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) return AuthState.emailNotVerified;
      return AuthState.loginFailed;
    } catch (e) {
      return AuthState.loginFailed;
    }
  }

  Future<void> requestNewAccessToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh');

      Response response = await _dio.post(
        '${ApiConstants.cyclic}/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      final newAccessToken = response.data['accessToken'];
      print('New access token: $newAccessToken');

      // Update the access token in SharedPreferences
      prefs.setString('access', newAccessToken);
    } catch (error) {
      print('Access token could not be re-generated $error');
      rethrow;
    }
  }

  Future<void> regenerateToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh');

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

  Future<bool> register({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    print('$username $email $phoneNumber $password');

    final uri = '${ApiConstants.cyclic}/auth/register';
    try {
      final Response response = await _dio.put(
        uri,
        data: {
          'username': username,
          'email': email,
          'phone_number': phoneNumber,
          'password': password,
        },
      );

      print(response.statusMessage);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
        // } else if (response.statusCode == 409) {
        //   // final scaffoldKey = GlobalKey<ScaffoldState>();
        //   // scaffoldKey.currentState!.showBottomSheet((context) {
        //   return ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //   //});
        //   return false;
        // } else if (response.statusCode == 500) {
        //   final scaffoldKey = GlobalKey<ScaffoldState>();
        //   scaffoldKey.currentState!.showBottomSheet((context) {
        //     return ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //   });
        //   return false;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to signup: $e');
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    navigatorKey.currentState?.pushReplacementNamed('/login');
  }
}
