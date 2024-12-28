import 'package:dio/dio.dart';
import 'shared_preference_manager.dart';
import '../resources/constants.dart';

class DioInterceptor extends Interceptor {
  final Dio dio;

  DioInterceptor({
    required this.dio,
  });
  
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final spm = await SharedPreferencesManager.getInstance();
    if (spm != null &&
        spm.isKeyExists(SharedPreferencesManager.keyAccessToken)) {
      final accessToken =
          spm.getString(SharedPreferencesManager.keyAccessToken);
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final spm = await SharedPreferencesManager.getInstance();
      if (spm != null &&
          spm.isKeyExists(SharedPreferencesManager.keyRefreshToken)) {
        final refreshToken =
            spm.getString(SharedPreferencesManager.keyRefreshToken);
        final newAccessToken = await _refreshToken(refreshToken!);
        if (newAccessToken != null) {
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newAccessToken';
          return handler.resolve(await dio.fetch(options));
        }
      }
    }
    super.onError(err, handler);
  }

  Future<String?> _refreshToken(String refreshToken) async {
    try {
      final spm = await SharedPreferencesManager.getInstance();
      const baseUri = '$baseUrl/api/auth';
      final options = BaseOptions(baseUrl: baseUri.toString());
      final dio = Dio(options);
      final response = await dio.post('refresh-token', data: {
        'refreshToken': refreshToken,
      });
      if (response.statusCode == 200 && spm != null) {
        await spm.putString(SharedPreferencesManager.keyAccessToken,
            response.data['accessToken']);
        await spm.putString(SharedPreferencesManager.keyRefreshToken,
            response.data['refreshToken']);
        return response.data['accessToken'];
      }
      return null;
    } catch (_) {
      rethrow;
    }
  }
}
