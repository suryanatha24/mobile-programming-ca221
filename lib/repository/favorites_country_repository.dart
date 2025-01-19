import 'dart:async';
import 'package:negara_apps/helper/database_helper.dart';
import 'package:negara_apps/model/country.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesCountryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await _databaseHelper.database;
    return await db.query('favorites');
  }

  Future<void> addFavorite(Country country) async {
    final db = await _databaseHelper.database;
    try {
      await db.insert(
      'favorites',
      country.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    } catch (e) {
      print(e);
    }
    
  }

  Future<void> removeFavorite(String countryName) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'favorites',
      where: 'name = ?',
      whereArgs: [countryName],
    );
  }

  Future<bool> isFavorite(String countryName) async {
    final db = await _databaseHelper.database;
    final result = await db.query(
      'favorites',
      where: 'name = ?',
      whereArgs: [countryName],
    );
    return result.isNotEmpty;
  }
}
