import 'dart:convert';

import 'package:app/shared/models/article.dart';
import 'package:app/shared/utils/api_constants.dart';
import 'package:dio/dio.dart';

class NewsRepo {
  static Dio dio = Dio();
  static Future<List<Article>> fetchAllArticles(int page,
      {int pageSize = 10}) async {
    Response response = await dio.get('${ApiConstants.cyclic}/news',
        queryParameters: {'page': page, 'pageSize': pageSize});

    if (response.statusCode == 200) {
      await Future.delayed(const Duration(milliseconds: 200));
      final List<dynamic> responseData = response.data;
      final List<Article> result = articleFromJson(json.encode(responseData));

      return result;
    } else {
      print('Failed to fetch articles. Status code: ${response.statusCode}');
      return [];
    }
  }
}
