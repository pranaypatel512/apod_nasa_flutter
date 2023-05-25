import 'package:apod_nasa_flutter/home/data/api/apod_nasa_api.dart';
import 'package:apod_nasa_flutter/provider/home_media_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home/data/repo/apod_nasa_repo.dart';
import '../model/api_response_state.dart';
import 'network_provider.dart';

final mediaListProvider = Provider<APODNasaAPI>((ref) {
  return APODNasaAPI(ref.read(dioInstanceProvider));
});

final homeMediaRepositoryProvider = Provider<APODNasaRepo>((ref) {
  return APODNasaRepo(ref.read(mediaListProvider));
});

final homeListProvider =
    StateNotifierProvider<HomeMedialListProvider, APIResponseState>((ref) {
  return HomeMedialListProvider(ref.read(homeMediaRepositoryProvider));
});
