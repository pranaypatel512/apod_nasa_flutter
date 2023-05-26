import 'package:apod_nasa_flutter/home/data/api/apod_nasa_api.dart';

import '../../../model/media_response.dart';


class APODNasaRepo {
  final APODNasaAPI apodNasaAPI;

  APODNasaRepo(this.apodNasaAPI);

  Future<List<MediaListResponse>> fetchMedialList() async {
    return apodNasaAPI.fetchAllMedia();
  }
}
