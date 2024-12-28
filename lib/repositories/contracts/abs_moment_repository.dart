import '../../models/moment.dart';

abstract class AbsMomentRepository {
  Future<void> addMoment(Moment moment);
  Future<void> updateMoment(Moment moment);
  Future<void> deleteMoment(String momentId);
  Future<List<Moment>> getAllMoments();
  Future<Moment?> getMomentById(String momentId);
}