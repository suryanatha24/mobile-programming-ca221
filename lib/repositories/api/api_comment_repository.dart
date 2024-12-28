import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myapp/models/comment.dart';

import '../../core/helpers/dio_interceptor.dart';
import '../../core/resources/constants.dart';
import '../contracts/abs_api_comment_repository.dart';

class ApiCommentRepository extends AbsApiCommentRepository {
  final _baseUri = '$baseUrl/api/moments/:momentId/comments';
  late Dio _dio;
  late BaseOptions _options;

  ApiCommentRepository() {
    _options = BaseOptions(
      baseUrl: _baseUri,
    );
    _dio = Dio(_options);
    _dio.interceptors.add(DioInterceptor(dio: _dio));
  }

  @override
  Future<Comment?> create(Comment newData) async {
    try {
      final response = await _dio.post('', data: newData.toMap());
      if (response.statusCode == 201) {
        return Comment.fromMap(response.data);
      }
    } catch (e) {
      log(e.toString(), name: 'ApiCommentRepository:create');
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
      log(e.toString(), name: 'ApiCommentRepository:delete');
    }
    return false;
  }

  @override
  Future<List<Comment>> getAll([String keyword = '']) async {
    try {
      final response = await _dio.get(
        '/all',
        queryParameters: {'keyword': keyword},
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => Comment.fromMap(e)).toList();
      }
    } catch (e) {
      log(e.toString(), name: 'ApiCommentRepository:getAll');
    }
    return [];
  }

  @override
  Future<Comment?> getById(String id) async {
    try {
      final response = await _dio.get('/$id');
      if (response.statusCode == 200) {
        return Comment.fromMap(response.data);
      }
    } catch (e) {
      log(e.toString(), name: 'ApiCommentRepository:getById');
    }
    return null;
  }

  @override
  Future<List<Comment>> getWithPagination(
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
        return (response.data as List).map((e) => Comment.fromMap(e)).toList();
      }
    } catch (e) {
      log(e.toString(), name: 'ApiCommentRepository:getWithPagination');
    }
    return [];
  }

  @override
  Future<bool> update(Comment updatedData) async {
    try {
      final response =
          await _dio.put('/${updatedData.id}', data: updatedData.toMap());
      if (response.statusCode == 204) {
        return true;
      }
    } catch (e) {
      log(e.toString(), name: 'ApiCommentRepository:update');
    }
    return false;
  }
}

















































// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../../models/comment.dart';

// class ApiCommentRepository {
//   final String baseUrl;

//   ApiCommentRepository({required this.baseUrl});

//   // Get All Comments
//   Future<List<Comment>> getAll([String keyword = '']) async {
//     final url = Uri.parse('$baseUrl/comments?search=$keyword');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       return data.map((comment) => Comment.fromMap(comment)).toList();
//     } else {
//       throw Exception('Failed to load comments');
//     }
//   }

//   // Get Comment by ID
//   Future<Comment?> getById(String id) async {
//     final url = Uri.parse('$baseUrl/comments/$id');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       return Comment.fromJson(response.body);
//     } else {
//       throw Exception('Failed to load comment');
//     }
//   }

//   // Create a new Comment
//   Future<Comment?> create(Comment newData) async {
//     final url = Uri.parse('$baseUrl/comments');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode(newData.toDto()),
//     );

//     if (response.statusCode == 201) {
//       return Comment.fromJson(response.body);
//     } else {
//       throw Exception('Failed to save comment');
//     }
//   }

//   // Update an existing Comment
//   Future<bool> update(Comment updatedData) async {
//     final url = Uri.parse('$baseUrl/comments/${updatedData.id}');
//     final response = await http.put(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode(updatedData.toDto()),
//     );

//     return response.statusCode == 200;
//   }

//   // Delete a Comment
//   Future<bool> delete(String id) async {
//     final url = Uri.parse('$baseUrl/comments/$id');
//     final response = await http.delete(url);

//     return response.statusCode == 200;
//   }
// }
