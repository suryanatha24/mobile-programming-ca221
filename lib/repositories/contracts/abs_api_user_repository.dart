import '../../models/user.dart';

abstract class AbsApiUserRepository {
  Future<List<User>> getAll([String keyword = '']);
  Future<List<User>> getWithPagination(
      [int page = 1, int size = 10, String keyword = '']);
  Future<User?> getById(String id);
  Future<User?> create(User newData);
  Future<bool> update(User updatedData);
  Future<bool> delete(String id);
}
