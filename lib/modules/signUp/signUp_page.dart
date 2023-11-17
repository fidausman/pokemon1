import 'package:app/modules/login/login_page.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/background_image.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/rounded_button.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/credential_text_field.dart';
import 'package:app/theme/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
    // String phone;
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
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
                                credentialTextField(
                                  textFromField: userName,
                                  icon: Icons.person,
                                  hint: 'UserName',
                                  inputAction: TextInputAction.next,
                                ),
                                credentialTextField(
                                  textFromField: email,
                                  icon: Icons.email,
                                  hint: 'Email',
                                  inputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[700]?.withOpacity(
                                          0.7,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: IntlPhoneField(
                                      decoration: InputDecoration(
                                          // contentPadding:
                                          //     const EdgeInsets.symmetric(
                                          //         vertical: 10),
                                          border: InputBorder.none,
                                          hintText: 'Phone',
                                          hintStyle: kBodyText,
                                          // prefixIcon: Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 20),
                                          //   child: Icon(Icons.phone, size: 30),
                                          // ),
                                          prefixIconColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => states.contains(
                                                          MaterialState.focused)
                                                      ? Colors.red
                                                      : Colors.grey.shade800)),
                                      style: kBodyText,
                                      keyboardType: TextInputType.phone,
                                      onChanged: (phone) {
                                        //  phone =phone.completeNumber;
                                      },
                                      textInputAction: TextInputAction.next,
                                    )),
                                credentialTextField(
                                    textFromField: password,
                                    icon: Icons.lock_outline,
                                    hint: 'Password',
                                    inputAction: TextInputAction.next,
                                    passText: true),
                                credentialTextField(
                                  textFromField: confirmPassword,
                                  icon: Icons.lock,
                                  hint: 'Confirm Password',
                                  inputAction: TextInputAction.done,
                                  passText: true,
                                ),
                              ]),
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              roundedButton(
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
