import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        focusDuration INTEGER,
        relaxDuration INTEGER,
        focusedTime INTEGER,
        relaxedTime INTEGER,
        date TEXT,
        iterationsNumber INTEGER
      )
    ''');
  }

  Future<DocumentReference<Map<String, dynamic>>> insertSession(PomodoroSession session) async {
    Database db = await database;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return await firestore.collection('sessions').add(session.toMap());
    // return await db.insert('pomodoro_sessions', session.toMap());
  }

  Future<void> clearSessions() async {
    // Database db = await database;
    // await db.delete('pomodoro_sessions');
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('sessions').where('userEmail', isEqualTo: user!.email).get().then((value) {
      for (var element in value.docs) {
        element.reference.delete();
      }
    });
  }

  Future<List<PomodoroSession>> getSessions(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection('sessions')
        .where('userEmail', isEqualTo: email)
        .get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print(data);
      return PomodoroSession(
        focusDuration: Duration(seconds: data['focusDuration']),
        relaxDuration: Duration(seconds: data['relaxDuration']),
        focusedTime: Duration(seconds: data['focusedTime']),
        relaxedTime: Duration(seconds: data['relaxedTime']),
        beginDate: data['beginDate'].toDate(),
        endDate: data['endDate'].toDate(),
        iterationsNumber: data['iterationsNumber'],
      );
    }).toList();
    // Database db = await database;
    // final List<Map<String, dynamic>> maps = await db.query('pomodoro_sessions');
    // return List.generate(maps.length, (i) {
    //   return PomodoroSession(
    //     focusDuration: Duration(seconds: maps[i]['focusDuration']),
    //     relaxDuration: Duration(seconds: maps[i]['relaxDuration']),
    //     focusedTime: Duration(seconds: maps[i]['focusedTime']),
    //     relaxedTime: Duration(seconds: maps[i]['relaxedTime']),
    //     date: DateTime.parse(maps[i]['date']),
    //     iterationsNumber: maps[i]['iterationsNumber'],
    //   );
    // });
  }
}
