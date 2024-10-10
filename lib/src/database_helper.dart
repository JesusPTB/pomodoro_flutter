import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/pomodoro_session.dart';

class DatabaseHelper {

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'pomodoro.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pomodoro_sessions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workDuration INTEGER,
        breakDuration INTEGER,
        date TEXT,
        cycleCount INTEGER
      )
    ''');
  }

  Future<int> insertSession(PomodoroSession session) async {
    Database db = await database;
    return await db.insert('pomodoro_sessions', session.toMap());
  }

  Future<void> clearSessions() async {
    Database db = await database;
    await db.delete('pomodoro_sessions');
  }

  Future<List<PomodoroSession>> getSessions() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pomodoro_sessions');
    return List.generate(maps.length, (i) {
      return PomodoroSession(
        workDuration: Duration(seconds: maps[i]['workDuration']),
        breakDuration: Duration(seconds: maps[i]['breakDuration']),
        date: DateTime.parse(maps[i]['date']),
        cycleCount: maps[i]['cycleCount'],
      );
    });
  }
}
