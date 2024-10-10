import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/src/database_helper.dart';
import 'package:pomodoro_flutter/src/model/pomodoro_session.dart';

final historyProvider = FutureProvider<List<PomodoroSession>>((ref) async {
  return await DatabaseHelper().getSessions();
});