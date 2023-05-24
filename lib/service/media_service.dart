import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/media_response.dart';

class MediaService {
  Future<MediaListResponse?> fetchAllMedia() async {
    MediaListResponse? mediaList;
    try {
      // const baseUrl =
      // "https://api.nasa.gov/planetary/apod?api_key=cTmdDUVcvKLPgKsXjRZr8TLJyGbSWKlRezIOaOkS&count=10";
      const baseUrl = "https://jsonplaceholder.typicode.com/posts/2";
      final url = Uri.parse(baseUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        mediaList = MediaListResponse.fromJson(responseJson);
      } else {
        print("error:${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
    return mediaList;
  }
}
