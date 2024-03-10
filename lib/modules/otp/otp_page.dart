import 'dart:developer';

import 'package:app/modules/forgot_password/reset_password.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/rounded_button.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:app/theme/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../shared/ui/widgets/login and SignUp/background_image.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.secret,
    required this.email,
  });

  final String email;
  final String secret;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 56,
        height: 60,
        textStyle: const TextStyle(
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
                      margin: const EdgeInsets.only(top: 40),
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Text('Verification',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold)),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 40),
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
                            controller: pinController,
                            length: 6,
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
                                    onPressed: () async {
                                      print(widget.secret);
                                      try {
                                        Response response = await Dio().post(
                                          "${ApiConstants.cyclic}/otp/verify",
                                          data: {
                                            'secret': widget.secret,
                                            'otp': pinController.text
                                          }, // Set data parameter to an empty map for an empty body
                                        );
                                        if (response.statusCode == 201) {
                                          log(widget.email);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ResetPasswordPage(
                                                          emailId:
                                                              widget.email)));
                                        }
                                        print("Response: $response");
                                      } catch (e) {
                                        print("Error: $e");
                                      }
                                    },
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
