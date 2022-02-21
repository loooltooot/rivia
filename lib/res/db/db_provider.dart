import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider dbProvider = DatabaseProvider._();
  static Database? _db;

  Future<Database> get db async {
    if(_db != null) return _db!;

    _db = await openDB();
    return _db!;
  }

  Future<Database> openDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    final db = openDatabase(
        join(await getDatabasesPath(), 'rivia.db'),
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE keys(id INTEGER PRIMARY KEY, val TEXT)'
          );
          await db.execute(
              'CREATE TABLE tables(id INTEGER PRIMARY KEY, val TEXT)'
          );
        },
        version: 1
    );
    return db;
  }

  Future<void> insertKey(String key) async {
    final db = await dbProvider.db;

    await db.insert(
        'keys',
        {
          'id': 0,
          'val': key
        },
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
  
  Future<String> getKey() async {
    final db = await dbProvider.db;
    
    var keys = await db.query('keys', where: 'id = ?', whereArgs: [0]);

    return keys.isEmpty ? 'emir' : keys.first['val'].toString();
  }

  Future<void> insertTable(String table) async {
    final db = await dbProvider.db;

    await db.insert(
        'tables',
        {
          'id': 0,
          'val': table
        },
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<String?> getTable() async {
    final db = await dbProvider.db;

    var tables = await db.query('tables', where: 'id = ?', whereArgs: [0]);

    return tables.isEmpty ? null : tables.first['val'].toString();
  }
}