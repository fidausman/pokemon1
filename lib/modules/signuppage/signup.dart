import 'package:app/main.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: Padding(
        
        padding: const EdgeInsets.all(20),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign Up',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(height: 20.h,),
            AnimatedImage(),
            
            // Image(image: AssetImage(
              
              // 'assets/images/login2.jpg') ),
      
             SizedBox(height: 20.h,),
            
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "email",
                    border: OutlineInputBorder()
                  ),
                ),
                 SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder()
                  ),
                ),
                 SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: " Confirm Password",
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Phone number",
                    border: OutlineInputBorder(),
                  ),
                ),
               
                
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
    );
  }
}
