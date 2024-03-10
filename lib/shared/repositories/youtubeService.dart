import 'dart:convert';

import 'package:app/shared/models/youtubeModel.dart';
import 'package:dio/dio.dart';

class youtubeRepo {
  static Dio dio = Dio();
  static Future<YoutubeModel> getVideo(String key) async {
    try {
      final Response response = await dio.get(
          'https://www.googleapis.com/youtube/v3/search',
          queryParameters: {
            'chart': 'mostPopular',
            'part': 'snippet',
            'type': 'video',
            'q': 'pokemon',
            'maxResults': '25',
            'key': key,
          });
      final YoutubeModel result =
          youtubeModelFromJson(jsonEncode(response.data));
      return result;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
