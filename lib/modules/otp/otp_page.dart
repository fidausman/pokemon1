import 'package:app/shared/ui/widgets/login%20and%20SignUp/rounded_button.dart';
import 'package:app/theme/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../shared/ui/widgets/login and SignUp/background_image.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 56,
        height: 60,
        textStyle: TextStyle(
          fontSize: 22,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.transparent)));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('OTP TextField'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          backgroundImage(),
          Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                      margin: EdgeInsets.only(top: 40),
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Text('Verification',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold)),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 40),
                            child: Text('Enter the code sent to your email',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.sp)),
                          ),
                          Container(
                              margin: const EdgeInsets.only(bottom: 40),
                              child: Text('email',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.sp))),
                          Pinput(
                            length: 4,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: defaultPinTheme.copyWith(
                                decoration: defaultPinTheme.decoration!
                                    .copyWith(
                                        border: Border.all(color: Colors.red))),
                            onCompleted: (pin) => debugPrint(pin),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Text(
                            'Resend Otp',
                            style: kBodyText.copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(16)),
                              width: 150,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextButton(
                                    onPressed: () =>
                                        Navigator.pushNamed(context, '/home'),
                                    child: Text(
                                      'verify',
                                      style: kBodyText.copyWith(
                                          color: Colors.white),
                                    )),
                              )),
                        ],
                      )))),
        ],
      ),
    );
  }
}
