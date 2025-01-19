import 'dart:async';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  final int databaseVersion = 1;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'favorites.db');

    return await openDatabase(path,
        version: databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    log("Creating database version $version...");
    await _newInVersion1(db); // Call version 1 schema
    if (version > 1) {
      await _onUpgrade(db, 1, version); // Apply future upgrades if needed
    }
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    log("Upgrading database from version $oldVersion to $newVersion...");
  }

  Future<void> _newInVersion1(Database db) async {
    await db.execute('''
          CREATE TABLE favorites(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            capital TEXT,
            region TEXT,
            population INTEGER,
            flagUrl TEXT,
            languages TEXT
          )
        ''');
  }
}
