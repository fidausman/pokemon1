import 'package:app/modules/login/login_page.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/backgroundImage.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/passwordInput.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/roundedButton.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/textInput.dart';
import 'package:app/theme/textStyles.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundImage(),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: 70,
                        child: Center(child: Text('Pokemon', style: kHeading))),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextInput(
                                  icon: Icons.person,
                                  hint: 'UserName',
                                  inputAction: TextInputAction.next,
                                ),
                                TextInput(
                                  icon: Icons.email,
                                  hint: 'Email',
                                  inputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next,
                                ),
                                TextInput(
                                  icon: Icons.phone,
                                  hint: 'Phone',
                                  inputType: TextInputType.phone,
                                  inputAction: TextInputAction.next,
                                ),
                                PasswordInput(
                                  icon: Icons.lock_outline,
                                  hint: 'Password',
                                  inputAction: TextInputAction.next,
                                ),
                                PasswordInput(
                                  icon: Icons.lock,
                                  hint: 'Confirm Password',
                                  inputAction: TextInputAction.done,
                                ),
                              ]),
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              RoundedButton(
                                  buttonText: 'SignUp',
                                  onpress: () =>
                                      Navigator.pushNamed(context, '/home')),
                              SizedBox(
                                height: 30,
                              ),
                              Wrap(
                                children: [
                                  Text("Already have an account?"),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                    child: Text('SignIn',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          )
                        ],
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
