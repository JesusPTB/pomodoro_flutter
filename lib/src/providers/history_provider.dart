import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/src/database_helper.dart';
import 'package:pomodoro_flutter/src/model/pomodoro_session.dart';

import 'auth_provider.dart';

final historyProvider = FutureProvider<List<PomodoroSession>>((ref) async {
  final user = ref.watch(authProvider.notifier).user;
  return await DatabaseHelper().getSessions(user!.email!);
});