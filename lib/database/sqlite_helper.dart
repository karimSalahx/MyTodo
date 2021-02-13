import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SqliteHelper {
  // A database can have more than one table but we are using only one here
  static final _dbName = 'myTodo.db';
  static final _dbVersion = 1;
  static final _tableName = 'myTable';

  // Making it a singletone class
  SqliteHelper._();
  static final SqliteHelper instance = SqliteHelper._();
  // returns a database which is used for making commands and is obtained when opening database
  static Database _database;
  Future<Database> get database async {
    // if database is inisitaed we return it if not we initiate it
    if (_database != null) return _database;
    _database = await _initiateDatabase();
    return _database;
  }

  Future<Database> _initiateDatabase() async {
    // Path to a directory where the application may place data that is user-generated, or that cannot otherwise be recreated by your application.
    Directory directory = await getApplicationDocumentsDirectory();
    // diretoryname/myTodo.db <= path
    String path = join(directory.path, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(id INTEGER PRIMARY KEY , priority INTEGER , title TEXT , dateTime TEXT , isFinished INTEGER)
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    // inserting a row into the database and it returns int the last known id
    return await db.insert(_tableName, row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    // return all rows in table
    return await db.query(_tableName);
  }

  // This is why we made the class singletone because we are using the same instance again and again
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    // return number of changes made
    return await db.update(
      _tableName,
      row,
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Returns no of rows affected
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
