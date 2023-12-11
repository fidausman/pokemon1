import 'dart:convert';
import 'dart:developer';

import 'package:app/modules/forgot_password/forgot_password.dart';
import 'package:app/modules/login/jwtToken.dart';
import 'package:app/modules/otp/otp_page.dart';
import 'package:app/modules/otp_api.dart';
import 'package:app/modules/signUp/signUp_page.dart';
import 'package:app/shared/providers/auth_state_provider.dart';
import 'package:app/shared/refresh_tokens.dart';
import 'package:app/shared/repositories/auth_service_repository.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/background_image.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/password_text_field.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/rounded_button.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/credential_text_field.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:app/theme/textStyles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Auth
  final authService = AuthService();
  @override
  void initState() {
    super.initState();
    checkIfCredentialsExistOnDevice();
  }

  Future<void> checkIfCredentialsExistOnDevice() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('email') && prefs.containsKey('password')) {
      final email = prefs.getString('email')!;
      final password = prefs.getString('password')!;
      final AuthState loginResult = await AuthService().login(email, password);
      if (loginResult == AuthState.LOGIN_SUCCESS) {
        context.read<AuthProvider>().getUserInfo();
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pop(context);
        return;
      }
    }
  }

  final loginKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? validator(String? value) {
      if (value != null || value != "") {
        return 'This field must not be empty';
      } else {
        return null;
      }
    }

    return Stack(
      children: [
        backgroundImage(),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // const SizedBox(
                    //     height: 150,
                    //     child: Center(child: Text('Pokemon', style: kHeading))),
                    // const SizedBox(
                    //   height: 100,
                    // ),
                    SizedBox(
                      height: 150,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Form(
                        key: loginKey,
                        child: Column(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CredentialTextField(
                                    validator: validator,
                                    textFromField: email,
                                    icon: Icons.email,
                                    hint: 'Email',
                                    inputType: TextInputType.emailAddress,
                                    inputAction: TextInputAction.next,
                                  ),
                                  PasswordTextField(
                                      validator: validator,
                                      textFromField: password,
                                      icon: Icons.lock,
                                      hint: 'Password',
                                      inputAction: TextInputAction.done),
                                  InkWell(
                                      onTap: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ForgotPasswordPage()));
                                      },
                                      child: Text('Forgot Password',
                                          style: kBodyText.copyWith(
                                              color: Colors.white))),
                                ]),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                roundedButton(
                                    buttonText: 'Login',
                                    onpress: () async {
                                      final isValid =
                                          loginKey.currentState!.validate();
                                      if (isValid) {
                                        try {
                                          Dio dio = Dio();
                                          Response response = await dio.post(
                                              '${ApiConstants.ngrokUrl}/auth/login',
                                              data: {
                                                "email": email.text,
                                                "password": password.text
                                              });
                                          log(response.toString());
                                          Map<String, dynamic> result =
                                              response.data;
                                          JwtToken tokens =
                                              JwtToken.fromJson(result);
                                          TokenManager.saveRefreshToken(
                                              tokens.refresh);
                                          Navigator.pushNamed(context, '/home');
                                        } catch (e) {
                                          log(e.toString());
                                        }
                                      }
                                    }),
                                const SizedBox(
                                  height: 30,
                                ),
                                Wrap(
                                  children: [
                                    const Text("Don't have an account?",
                                        style: TextStyle(color: Colors.white)),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUpPage()));
                                      },
                                      child: const Text('SignUp',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
