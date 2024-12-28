import '../../models/comment.dart';

abstract class AbsApiCommentRepository {
  Future<List<Comment>> getAll([String keyword = '']);
  Future<List<Comment>> getWithPagination(
      [int page = 1, int size = 10, String keyword = '']);
  Future<Comment?> getById(String id);
  Future<Comment?> create(Comment newData);
  Future<bool> update(Comment updatedData);
  Future<bool> delete(String id);
}
