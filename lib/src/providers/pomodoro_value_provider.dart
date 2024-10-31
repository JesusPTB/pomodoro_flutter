import 'package:flutter_riverpod/flutter_riverpod.dart';

class PomodoroValue {
  late  Duration workDuration;
  late  Duration breakDuration;

  PomodoroValue({
    required this.workDuration,
    required this.breakDuration,
  });

  setWorkDuration(Duration duration) {
    workDuration = duration;
  }

  setBreakDuration(Duration duration) {
    breakDuration = duration;
  }

  Duration getWorkDuration() {
    return workDuration;
  }

  Duration getBreakDuration() {
    return breakDuration;
  }

  setLongPomodoro() {
    workDuration = const Duration(minutes: 45);
    breakDuration = const Duration(minutes: 15);
  }

  setShortPomodoro() {
    workDuration = const Duration(minutes: 25);
    breakDuration = const Duration(minutes: 5);
  }

  setTestPomodoro() {
    workDuration = const Duration(seconds: 25);
    breakDuration = const Duration(seconds: 5);
  }
}

final pomodoroValuesProvider = StateProvider<PomodoroValue>(
  (ref) => PomodoroValue(
    workDuration: const Duration(minutes: 12),
    breakDuration: const Duration(minutes: 15),
  ),
);
