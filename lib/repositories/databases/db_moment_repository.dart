import 'dart:developer';

import 'package:myapp/core/helpers/database_helper.dart';
import 'package:myapp/models/moments.dart';
import 'package:myapp/repositories/contracts/abs_moment_repository.dart';

class DbMomentRepository extends AbsMomentRepository {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  Future<void> addMoment(Moment moment) async {
    try {
      final db = await databaseHelper.database;
      await db.insert(
        DatabaseHelper.tableMoments,
        moment.toMap()
      );
    } catch (e) {
      log(e.toString(), name: 'db_moment_repository:addMoment');
    }
  }

  @override
  Future<void> deleteMoment(String momentId) async {
    try {
      final db = await databaseHelper.database;
      await db.delete(
        DatabaseHelper.tableMoments,
        where: 'id = ?',
        whereArgs: [momentId]
      );
    } catch (e) {
      log(e.toString(), name: 'db_moment_repository:deleteMoment');
    }
  }

  @override
  Future<List<Moment>> getAllMoments() async {
    try {
      final db = await databaseHelper.database;
      final result = await db.query(DatabaseHelper.tableMoments);

      return result.map((e) => Moment.fromMap(e)).toList();
    } catch (e) {
      log(e.toString(), name: 'db_moment_repository:getAllMoments');
      return [];
    }
  }

  @override
  Future<Moment?> getMomentById(String momentId) async {
    try {
      final db = await databaseHelper.database;
      final result = await db.query(
        DatabaseHelper.tableMoments,
        where: 'id = ?',
        whereArgs: [momentId]
      );
      if (result.isEmpty) {
        return null;
      } else {
        return Moment.fromMap(result.first);
      }
    } catch (e) {
      log(e.toString(), name: 'db_moment_repository:getMomentById');
      return null;
    }
  }

  @override
  Future<void> updateMoment(Moment moment) async {
    try {
      final db = await databaseHelper.database;
      await db.update(
        DatabaseHelper.tableMoments,
        moment.toMap(),
        where: 'id = ?',
        whereArgs: [moment.id]
      );
    } catch (e) {
      log(e.toString(), name: 'db_moment_repository:updateMoment');
    }
  }
}