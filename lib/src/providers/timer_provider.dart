import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/src/database_helper.dart';
import 'package:pomodoro_flutter/src/providers/history_provider.dart';
import 'package:pomodoro_flutter/src/providers/pomodoro_value_provider.dart';
import 'package:quiver/async.dart';

import '../model/pomodoro_session.dart';

class TimerNotifier extends StateNotifier<Duration> {
  TimerNotifier(this.ref) : super(Duration.zero) {
    durations = ref.read(pomodoroValuesProvider);
  }

  int cycleCount = 0;
  final Ref ref;
  CountdownTimer? _timer;
  late PomodoroValue durations;
  bool isWork = true;
  bool reset = false;

  void startTimer() {
    _timer?.cancel();
    final duration = isWork ? durations.workDuration : durations.breakDuration;
    _timer = CountdownTimer(
      duration,
      const Duration(seconds: 1),
    );

    _timer!.listen((event) {
      state = event.remaining;
    }, onDone: () async {
      if (!isWork) {
        cycleCount++;
      }
      isWork = !isWork;
      if (reset) {
        reset = false;
        return;
      } else {
        startTimer();
      }
    });
  }


  void cancelTimer() {
    reset = true;
    _timer?.cancel();
    final dbHelper = DatabaseHelper();
    dbHelper.insertSession(PomodoroSession(
      workDuration: durations.workDuration,
      breakDuration: durations.breakDuration,
      date: DateTime.now(),
      cycleCount: cycleCount,
    ));
    ref.refresh(historyProvider); //@todo: peut etre refresh quand on arrive sur l'onglet historique pour opti

    cycleCount = 0;
    state = Duration.zero;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, Duration>((ref) {
  return TimerNotifier(ref);
});