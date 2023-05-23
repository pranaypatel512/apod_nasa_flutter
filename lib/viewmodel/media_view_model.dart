import 'package:apod_nasa_flutter/model/media_response.dart';
import 'package:apod_nasa_flutter/service/media_service.dart';
import 'package:flutter/material.dart';

class MediaViewModel extends ChangeNotifier {
  final service = MediaService();
  bool isLoading = false;
  List<MediaListResponse> _mediaItems = [];
  List<MediaListResponse> get mediaItems => _mediaItems;

  Future<void> loadAllMedia() async {
    isLoading = true;
    notifyListeners();
    final respose = await service.fetchAllMedia();
    _mediaItems = respose;
    notifyListeners();
  }
}
