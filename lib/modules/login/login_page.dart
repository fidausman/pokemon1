import 'package:app/modules/signUp/signUp_page.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/backgroundImage.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/passwordInput.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/roundedButton.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/textInput.dart';
import 'package:app/theme/textStyles.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                        height: 150,
                        child: Center(child: Text('Pokemon', style: kHeading))),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextInput(
                                  icon: Icons.email,
                                  hint: 'Email',
                                  inputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next,
                                ),
                                PasswordInput(
                                  icon: Icons.lock,
                                  hint: 'Password',
                                  inputAction: TextInputAction.done,
                                ),
                                Text('Forgot Password', style: kBodyText),
                              ]),
                          Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              RoundedButton(
                                buttonText: 'Login',
                                onpress: () =>
                                    Navigator.pushNamed(context, '/home'),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              Wrap(
                                children: [
                                  Text("Don't have an account?"),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpPage()));
                                    },
                                    child: Text('SignUp',
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
