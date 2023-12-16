import 'dart:developer';

import 'package:app/modules/login/login_page.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/background_image.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/password_text_field.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/rounded_button.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/credential_text_field.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:app/theme/textStyles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final signUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String? validaor(String? value) {
      if (value == null || value == "") {
        return 'This field must not be empty';
      } else {
        return null;
      }
    }

    TextEditingController userName = TextEditingController();
    TextEditingController phoneNo = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    return Stack(
      children: [
        backgroundImage(),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: ListView(
                children: [
                  // const SizedBox(
                  //     height: 70,
                  //     child: Center(child: Text('Pokemon', style: kHeading))),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: signUpKey,
                      child: Column(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CredentialTextField(
                                  validator: validaor,
                                  textFromField: userName,
                                  icon: Icons.person,
                                  hint: 'UserName',
                                  inputAction: TextInputAction.next,
                                ),
                                CredentialTextField(
                                  validator: validaor,
                                  textFromField: email,
                                  icon: Icons.email,
                                  hint: 'Email',
                                  inputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next,
                                ),
                                CredentialTextField(
                                  validator: validaor,
                                  textFromField: phoneNo,
                                  icon: Icons.phone,
                                  hint: 'Phone',
                                  inputAction: TextInputAction.next,
                                ),
                                PasswordTextField(
                                  validator: validaor,
                                  textFromField: password,
                                  icon: Icons.lock_outline,
                                  hint: 'Password',
                                  inputAction: TextInputAction.next,
                                ),
                                PasswordTextField(
                                  validator: validaor,
                                  textFromField: confirmPassword,
                                  icon: Icons.lock,
                                  hint: 'Confirm Password',
                                  inputAction: TextInputAction.done,
                                ),
                              ]),
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              roundedButton(
                                  buttonText: 'SignUp',
                                  onpress: () async {
                                    final isValid =
                                        signUpKey.currentState!.validate();
                                    if (isValid) {
                                      try {
                                        Dio dio = Dio();
                                        Response response = await dio.post(
                                          '${ApiConstants.ngrokUrl}/auth/signup',
                                          data: {
                                            "userName": userName.text,
                                            "phone": phoneNo.text,
                                            "email": email.text,
                                            "password": password.text,
                                          },
                                        );
                                        log(response.toString());
                                        Navigator.pushNamed(context, '/login');
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
                                  const Text("Already have an account?",
                                      style: TextStyle(color: Colors.white)),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
                                    },
                                    child: const Text('SignIn',
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
            ))
      ],
    );
  }
}
