import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/media_response.dart';

class MediaService {
  Future<List<MediaListResponse>> fetchAllMedia() async {
    const baseUrl =
        "https://api.nasa.gov/planetary/apod?api_key=cTmdDUVcvKLPgKsXjRZr8TLJyGbSWKlRezIOaOkS&count=10";
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as List;
      final mediaList = responseJson
          .map((e) => MediaListResponse.fromJson(e as Map<String, dynamic>))
          .toList();
      return mediaList;
    }
    return [];
  }
}
