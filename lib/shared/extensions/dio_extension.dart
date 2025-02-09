import 'package:dio/dio.dart';

extension DioExtension on Dio {
  Dio copy() {
    Dio newClient = Dio(options);
    newClient.interceptors.addAll(interceptors);
    return newClient;
  }
}
