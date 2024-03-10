import 'dart:convert';
import 'dart:developer';

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

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final loginKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
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
                                    inputAction: TextInputAction.done,
                                  ),
                                ]),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 100,
                                ),
                                roundedButton(
                                    buttonText: 'Send Otp',
                                    onpress: () async {
                                      log('button');
                                      // final isValid =
                                      //     loginKey.currentState!.validate();
                                      // if (isValid) {
                                      try {
                                        Response response = await Dio().post(
                                            '${ApiConstants.cyclic}/users',
                                            data: {"email": email.text});
                                        if (response.statusCode == 201) {
                                          log('Checked');
                                          String result =
                                              await OtpApi().otpGenerate();
                                          //print(result);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OtpScreen(
                                                          email: email.text,
                                                          secret: result)));
                                        }
                                      } catch (e) {
                                        log(e.toString());
                                      }
                                      // }
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
