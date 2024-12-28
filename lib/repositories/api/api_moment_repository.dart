import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myapp/models/moment.dart';

import '../../core/helpers/dio_interceptor.dart';
import '../../core/resources/constants.dart';
import '../contracts/abs_api_moment_repository.dart';

class ApiMomentRepository extends AbsApiMomentRepository {
  final _baseUri = '$baseUrl/api/moments';
  late Dio _dio;
  late BaseOptions _options;

  ApiMomentRepository() {
    _options = BaseOptions(
      baseUrl: _baseUri,
    );
    _dio = Dio(_options);
    _dio.interceptors.add(DioInterceptor(dio: _dio));
  }

  @override
  Future<Moment?> create(Moment newData) async {
    try {
      final response = await _dio.post('', data: newData.toMap());
      if (response.statusCode == 201) {
        return Moment.fromMap(response.data);
      }
    } catch (e) {
      log(e.toString(), name: 'ApiMomentRepository:create');
    }
    return null;
  }

  @override
  Future<bool> delete(String id) async {
    try {
      final response = await _dio.delete('/$id');
      if (response.statusCode == 204) {
        return true;
      }
    } catch (e) {
      log(e.toString(), name: 'ApiMomentRepository:delete');
    }
    return false;
  }

  @override
  Future<List<Moment>> getAll([String keyword = '']) async {
    try {
      final response = await _dio.get(
        '/all',
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
  Future<Moment?> getById(String id) async {
    try {
      final response = await _dio.get('/$id');
      if (response.statusCode == 200) {
        return Moment.fromMap(response.data);
      }
    } catch (e) {
      log(e.toString(), name: 'ApiMomentRepository:getById');
    }
    return null;
  }

  @override
  Future<List<Moment>> getWithPagination(
      [int page = 1, int size = 10, String keyword = '']) async {
    try {
      final response = await _dio.get(
        '',
        queryParameters: {
          'PageNumber': page,
          'PageSize': size,
          'Keyword': keyword,
        },
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => Moment.fromMap(e)).toList();
      }
    } catch (e) {
      log(e.toString(), name: 'ApiMomentRepository:getWithPagination');
    }
    return [];
  }

  @override
  Future<bool> update(Moment updatedData) async {
    try {
      final response = await _dio.put('/${updatedData.id}', data: updatedData.toMap());
      if (response.statusCode == 204) {
        return true;
      }
    } catch (e) {
      log(e.toString(), name: 'ApiMomentRepository:update');
    }
    return false;
  }
}
