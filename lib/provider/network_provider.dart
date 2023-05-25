import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioInstanceProvider = Provider<Dio>((ref) {
  return Dio();
});