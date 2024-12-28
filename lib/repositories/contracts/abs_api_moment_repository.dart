import '../../models/moment.dart';

abstract class AbsApiMomentRepository {
  Future<List<Moment>> getAll([String keyword = '']);
  Future<List<Moment>> getWithPagination(
      [int page = 1, int size = 10, String keyword = '']);
  Future<Moment?> getById(String id);
  Future<Moment?> create(Moment newData);
  Future<bool> update(Moment updatedData);
  Future<bool> delete(String id);
}
