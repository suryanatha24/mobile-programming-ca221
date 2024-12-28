import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:myapp/core/helpers/shared_preference_manager.dart';
import 'package:myapp/core/resources/constants.dart';
import 'package:myapp/models/user.dart';

import '../contracts/abs_auth_repository.dart';

class ApiAuthRepository extends AbsAuthRepository {
  final _baseUri = '$baseUrl/api/auth';
  late Dio _dio;
  late BaseOptions _options;

  ApiAuthRepository() {
    _options = BaseOptions(
      baseUrl: _baseUri,
    );
    _dio = Dio(_options);
  }

  @override
  Future<(bool, String)> forgotPassword(String username) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<User?> info() async {
    try {
      final spm = await SharedPreferencesManager.getInstance();
      if (spm != null &&
          spm.isKeyExists(SharedPreferencesManager.keyActiveUser)) {
        return User.fromJson(
            spm.getString(SharedPreferencesManager.keyActiveUser)!);
      }
    } catch (e) {
      log(e.toString(), name: 'ApiAuthRepository:info');
    }
    return null;
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final spm = await SharedPreferencesManager.getInstance();
      if (spm != null &&
          spm.isKeyExists(SharedPreferencesManager.keyAccessToken)) {
        final accessToken =
            spm.getString(SharedPreferencesManager.keyAccessToken);
        final expiryDate = _getExpiryDate(accessToken!);
        if (expiryDate != null && expiryDate.isAfter(DateTime.now())) {
          return true;
        }
      }
    } catch (e) {
      log(e.toString(), name: 'ApiAuthRepository:isAuthenticated');
    }
    return false;
  }

  @override
  Future<(bool, String)> login(UserLoginDto dataLogin) async {
    try {
      final response = await _dio.post('/login', data: dataLogin.toMap());
      if (response.statusCode == 200) {
        await _storeUserData(response);
      }
      return (true, "User authentication success");
    } catch (e) {
      log(e.toString(), name: 'ApiAuthRepository:login');
    }
    return (false, 'Failed to authenticate user');
  }

  @override
  Future logout() async {
    try {
      final spm = await SharedPreferencesManager.getInstance();
      if (spm != null) {
        await spm.clearAll();
      }
    } catch (e) {
      log(e.toString(), name: 'ApiAuthRepository:logout');
    }
  }

  @override
  Future<bool> refreshToken() async {
    try {
      final spm = await SharedPreferencesManager.getInstance();
      if (spm != null &&
          spm.isKeyExists(SharedPreferencesManager.keyRefreshToken)) {
        final response = await _dio.post('/refresh-token', data: {
          'refreshToken':
              spm.getString(SharedPreferencesManager.keyRefreshToken),
        });
        if (response.statusCode == 200) {
          await _storeUserData(response);
        }
      }
      return true;
    } catch (e) {
      log(e.toString(), name: 'ApiAuthRepository:login');
    }
    return false;
  }

  @override
  Future<(bool, String)> register(UserRegisterDto dataRegister) async {
    try {
      final response = await _dio.post('/register', data: dataRegister.toMap());
      if (response.statusCode == 204) {
        return (true, "User registration success");
      }
    } catch (e) {
      log(e.toString(), name: 'ApiAuthRepository:register');
    }
    return (false, 'Failed to register new user');
  }

  DateTime? _getExpiryDate(String token) {
    final decodedToken = JwtDecoder.decode(token);
    if (decodedToken.isNotEmpty && decodedToken.containsKey('exp')) {
      int expirationTime = decodedToken['exp'];
      return DateTime.fromMillisecondsSinceEpoch(expirationTime * 1000);
    }
    return null;
  }

  Future<void> _storeUserData(Response<dynamic> response) async {
    try {
      final spm = await SharedPreferencesManager.getInstance();
      if (spm != null) {
        // Menyimpan accessToken
        await spm.putString(SharedPreferencesManager.keyAccessToken,
            response.data['accessToken']);
        // Menyimpan refreshToken
        await spm.putString(SharedPreferencesManager.keyRefreshToken,
            response.data['refreshToken']);
        // Menyimpan data User
        final activeUser = User.fromMap(response.data['userData']);
        await spm.putString(
          SharedPreferencesManager.keyActiveUser,
          activeUser.toJson(),
        );
        // Menyimpan data User ID
        await spm.putString(
          SharedPreferencesManager.keyActiveUserId,
          activeUser.id,
        );
      }
    } catch (e) {
      log(e.toString(), name: 'ApiAuthRepository:_storeUserData');
    }
  }
}
