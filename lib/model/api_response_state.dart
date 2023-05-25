
import 'package:apod_nasa_flutter/model/media_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_state.freezed.dart';

@freezed
class APIResponseState with _$APIResponseState {
  factory APIResponseState({
    @Default([]) List<MediaListResponse> list,
    @Default(true) bool isLoading,
  }) = _APIResponseState;
}