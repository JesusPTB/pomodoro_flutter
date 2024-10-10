
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/src/pomodoro.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  // sqfliteFfiInit();
  //
  // databaseFactory = databaseFactory;

  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(
      child: Pomodoro(),
    ),
  );
}