import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/media_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MediaService {
  Future<List<MediaListResponse>> fetchAllMedia() async {
    try {
      String apiKey = dotenv.env['api_key'] ?? "";
      String baseUrl =
          "https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=25";
      final url = Uri.parse(baseUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body) as List;
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
