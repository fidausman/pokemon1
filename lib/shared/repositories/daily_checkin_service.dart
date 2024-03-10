import 'dart:developer';

import 'package:app/shared/models/checkin_model.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';

class DailyCheckinService {
  DailyCheckinService._private();

  static final DailyCheckinService _instance = DailyCheckinService._private();
  static DailyCheckinService get instance => _instance;

  // Dio
  final dio = Dio();

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

  void removeInterceptor() {
    dio.interceptors.clear();
  }

  Future<Response<dynamic>> checkIn(String email) async {
    final String uri = '${ApiConstants.cyclic}/daily-checkin/check-in';

    final response = await dio.patch(
      uri,
      data: {'email': email},
    );
    return response;
  }

  Future<Response<dynamic>> getHistory(String email) async {
    final String uri = '${ApiConstants.cyclic}/daily-checkin/history';

    final Response response = await dio.post(uri, data: {'email': email});
    return response;
  }
}
