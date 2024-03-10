import 'dart:convert';

import 'package:app/modules/otp/otpModel.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';

class OtpApi {
  Future<String> otpGenerate() async {
    try {
      Response response = await Dio().post(
        "${ApiConstants.cyclic}/otp/generate",
        data: {}, // Set data parameter to an empty map for an empty body
      );
      print("Response: $response");

      if (response.statusCode == 201) {
        print(response.data);
        Map<String, dynamic> result = response.data;
        Otp otpRes = Otp.fromJson(result);
        print(otpRes);
        // return result['secret'];
        return otpRes.secret;
      }
      return 'Hi';
    } catch (e) {
      throw Exception(e);
    }
  }
}
