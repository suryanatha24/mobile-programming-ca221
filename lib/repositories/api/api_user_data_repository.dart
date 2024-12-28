import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myapp/models/moment.dart';

import 'package:myapp/models/user.dart';

import '../../core/helpers/dio_interceptor.dart';
import '../../core/resources/constants.dart';
import '../contracts/abs_api_user_data_repository.dart';

class ApiUserDataRepository extends AbsApiUserDataRepository {
  late String _baseUri;
  late Dio _dio;
  late BaseOptions _options;

  ApiUserDataRepository(String? userId) {
    _baseUri = '$baseUrl/api/users/$userId';
    _options = BaseOptions(
      baseUrl: _baseUri,
    );
    _dio = Dio(_options);
    _dio.interceptors.add(DioInterceptor(dio: _dio));
  }

  @override
  Future<bool> follow(String userId) {
    // TODO: implement follow
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAllFollings([String keyword = '']) {
    // TODO: implement getAllFollings
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAllFollowers([String keyword = '']) {
    // TODO: implement getAllFollowers
    throw UnimplementedError();
  }

  @override
  Future<List<Moment>> getAllMoments([String keyword = '']) async {
    try {
      final response = await _dio.get(
        '/moments',
        queryParameters: {'keyword': keyword},
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => Moment.fromMap(e)).toList();
      }
    } catch (e) {
      log(e.toString(), name: 'ApiMomentRepository:getAll');
    }
    return [];
  }

  @override
  Future<bool> unfollow(String userId) {
    // TODO: implement unfollow
    throw UnimplementedError();
  }
}
