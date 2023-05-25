import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../model/media_response.dart';

class APODNasaAPI {
  final Dio _dio;
  APODNasaAPI(this._dio);

  Future<List<MediaListResponse>> fetchAllMedia() async {
    try {
      String apiKey = dotenv.env['api_key'] ?? "";
      String baseUrl =
          "https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=25";
      final response = await _dio.get(baseUrl);

      if (response.statusCode == 200) {
        print("response:$response");
        final responseJson = response.data as List;
        final mediaList = responseJson.map((json) {
          return MediaListResponse(
              copyright: json['copyright'],
              date: json['date'],
              explanation: json['explanation'],
              hdurl: json['hdurl'],
              mediaType: json['media_type'],
              serviceVersion: json['service_version'],
              title: json['title'],
              url: json['url']);
        }).toList();
        return mediaList;
      } else {
        print("error:${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }
}
