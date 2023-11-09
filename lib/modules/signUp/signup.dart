import 'package:app/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 2, 43, 77),
            Color.fromRGBO(124, 180, 248, 1),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              // Image(image: AssetImage(

              // 'assets/images/login2.jpg') ),

              SizedBox(
                height: 20.h,
              ),

              Column(
                children: [
                  textField('Username'),
                  SizedBox(
                    height: 10.h,
                  ),
                  textField("email"),
                  SizedBox(
                    height: 10.h,
                  ),
                  textField("Password"),
                  SizedBox(
                    height: 10.h,
                  ),
                  textField("Confirm Password"),
                  SizedBox(
                    height: 10.h,
                  ),
                  textField("Phone number"),
                  SizedBox(
                    height: 30.h,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ));
                      },
                      child: Text("Signup")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(String hint) {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: hint,
          border: OutlineInputBorder()),
    );
  }
}
