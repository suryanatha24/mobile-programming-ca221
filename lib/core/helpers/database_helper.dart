import 'dart:async';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  final String databaseName = 'moments.db';
  final int databaseVersion = 1;
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
      onUpgrade: _onUpgrade,);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await _newInVersion1(db);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
  }

  Future close() async {
    final db = await database;
    db.close();
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
          createdAt TEXT,
          creator TEXT,
          comment TEXT,
          momentId TEXT
        )
      ''');
    } catch (e) {
      log(e.toString());
    }
  }
}