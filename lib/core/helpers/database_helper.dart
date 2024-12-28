import 'dart:async';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  final String databaseName = 'moments.db';
  final int databaseVersion = 2;
  static const String tableMoments = 'moments';
  static const String tableComments = 'comments';

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/$databaseName';
    return openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await _newInVersion1(db);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _upgradeToVersion2(db);
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }

  Future<void> dropTable(Database db, String tableName) async {
    try {
      await db.execute('DROP TABLE IF EXISTS $tableName');
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _newInVersion1(Database db) async {
    try {
      await db.execute('''
        CREATE TABLE $tableMoments (
          id TEXT PRIMARY KEY,
          momentDate TEXT,
          creator TEXT,
          location TEXT,
          imageUrl TEXT,
          caption TEXT,
          likeCount INTEGER,
          commentCount INTEGER,
          bookmarkCount INTEGER
        )
      ''');

      await db.execute('''
        CREATE TABLE $tableComments (
          id TEXT PRIMARY KEY,
          momentId TEXT,
          creator TEXT,
          content TEXT,
          createdAt TEXT
        )
      ''');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _upgradeToVersion2(Database db) async {
    try {
      await dropTable(db, tableMoments);
      await dropTable(db, tableComments);

      await db.execute('''
        CREATE TABLE $tableMoments (
          id TEXT PRIMARY KEY,
          creatorId TEXT,
          creatorUsername TEXT,
          creatorFullname TEXT,
          momentDate TEXT,
          caption TEXT,
          location TEXT,
          longitude REAL,
          latitude REAL,
          imageUrl TEXT,
          totalLikes INTEGER,
          totalComments INTEGER,
          totalBookmarks INTEGER,
          createdAt TEXT,
          lastUpdatedAt TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE $tableComments (
          id TEXT PRIMARY KEY,
          creatorId TEXT,
          creatorUsername TEXT,
          creatorFullname TEXT,
          momentId TEXT,
          content TEXT,
          createdAt TEXT,
          lastUpdatedAt TEXT
        )
      ''');
    } catch (_) {
      rethrow;
    }
  }
}
