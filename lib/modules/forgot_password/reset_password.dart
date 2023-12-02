import 'dart:convert';
import 'dart:developer';

import 'package:app/modules/forgot_password/forgot_password.dart';
import 'package:app/modules/login/login_page.dart';
import 'package:app/modules/otp/otp_page.dart';
import 'package:app/modules/otp_api.dart';
import 'package:app/modules/signUp/signUp_page.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/background_image.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/password_text_field.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/rounded_button.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/credential_text_field.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:app/theme/textStyles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({
    required this.emailId,
    super.key,
  });

  String emailId;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final loginKey = GlobalKey<FormState>();
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
                                    textFromField: password,
                                    icon: Icons.email,
                                    hint: 'Enter new password',
                                    inputType: TextInputType.emailAddress,
                                    inputAction: TextInputAction.next,
                                  ),
                                  CredentialTextField(
                                      validator: validator,
                                      textFromField: confirmPassword,
                                      icon: Icons.lock,
                                      hint: 'confirm Password',
                                      inputAction: TextInputAction.done),
                                ]),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 100,
                                ),
                                roundedButton(
                                    buttonText: 'Reset Password',
                                    onpress: () async {
                                      // final isValid =
                                      //     loginKey.currentState!.validate();
                                      // if (isValid) {
                                      try {
                                        log(widget.emailId);
                                        Dio dio = Dio();
                                        Response response = await dio.patch(
                                            '${ApiConstants.ngrokUrl}/users/reset-password',
                                            data: {
                                              "email": widget.emailId,
                                              "password": password.text
                                            });
                                        if (response.statusCode == 200) {
                                          Navigator.pushNamed(
                                              context, '/login');
                                        }
                                      } catch (e) {
                                        log(e.toString());
                                      }
                                      //}
                                    }),
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
