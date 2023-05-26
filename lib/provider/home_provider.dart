import 'package:apod_nasa_flutter/home/data/api/apod_nasa_api.dart';
import 'package:apod_nasa_flutter/provider/home_media_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../home/data/repo/apod_nasa_repo.dart';
import '../model/api_response_state.dart';
import 'network_provider.dart';

part 'home_provider.g.dart';

@riverpod
APODNasaAPI aPODNasaAPI(APODNasaAPIRef ref) =>
    APODNasaAPI(ref.read(dioProvider));

@riverpod
APODNasaRepo aPODNasaRepo(APODNasaRepoRef ref) =>
    APODNasaRepo(ref.read(aPODNasaAPIProvider));

// final homeMediaRepositoryProvider = Provider<APODNasaRepo>((ref) {
//   return APODNasaRepo(ref.read(aPODNasaAPIProvider));
// });

final homeListProvider =
    StateNotifierProvider<HomeMedialListProvider, APIResponseState>((ref) {
  return HomeMedialListProvider(ref.read(aPODNasaRepoProvider));
});
