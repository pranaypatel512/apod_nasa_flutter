import 'package:apod_nasa_flutter/model/media_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home/data/repo/apod_nasa_repo.dart';
import '../model/api_response_state.dart';

class HomeMedialListProvider extends StateNotifier<APIResponseState> {
  APODNasaRepo aPODNasaRepo;
  HomeMedialListProvider(this.aPODNasaRepo) : super(APIResponseState()) {
    getMediaList();
  }

  MediaListResponse? item;

  Future<void> getMediaList() async {
    state = state.copyWith(isLoading: true);
    await aPODNasaRepo
        .fetchMedialList()
        .then((value) => state = state.copyWith(list: value, isLoading: false));
  }
}
