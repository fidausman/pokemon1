import 'dart:convert';
import 'dart:developer';

import 'package:app/modules/forgot_password/forgot_password.dart';
import 'package:app/modules/login/jwtToken.dart';
import 'package:app/modules/otp/otp_page.dart';
import 'package:app/modules/otp_api.dart';
import 'package:app/modules/signUp/signUp_page.dart';
import 'package:app/shared/refresh_tokens.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/background_image.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/password_text_field.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/rounded_button.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/credential_text_field.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:app/theme/textStyles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? validator(String? value) {
      if (value != null || value != "") {
        return 'hi';
      } else {
        return "Error";
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
                    const SizedBox(
                        height: 150,
                        child: Center(child: Text('Pokemon', style: kHeading))),
                    const SizedBox(
                      height: 100,
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
                                      child: const Text('Forgot Password',
                                          style: kBodyText)),
                                ]),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 100,
                                ),
                                roundedButton(
                                    buttonText: 'Login',
                                    onpress: () async {
                                      // final isValid =
                                      //     loginKey.currentState!.validate();
                                      // if (isValid) {
                                      try {
                                        Dio dio = Dio();
                                        Response response = await dio.post(
                                            '${ApiConstants.ngrokUrl}/auth/login',
                                            data: {
                                              "email": email.text,
                                              "password": password.text
                                            });
                                        log(response.toString());
                                        // Map<String, dynamic> result =
                                        //     response.data;
                                        // JwtToken tokens =
                                        //     JwtToken.fromJson(result);
                                        // TokenManager.saveRefreshToken(
                                        //     tokens.refresh);
                                        Navigator.pushNamed(context, '/home');
                                      } catch (e) {
                                        log(e.toString());
                                      }
                                      // }
                                    }),
                                const SizedBox(
                                  height: 60,
                                ),
                                Wrap(
                                  children: [
                                    const Text("Don't have an account?"),
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
                                              fontWeight: FontWeight.bold)),
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
