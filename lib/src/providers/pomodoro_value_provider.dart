import 'package:flutter_riverpod/flutter_riverpod.dart';

class PomodoroValue {
  final Duration workDuration;
  final Duration breakDuration;

  PomodoroValue({
    required this.workDuration,
    required this.breakDuration,
  });
}

final pomodoroValuesProvider = StateProvider<PomodoroValue>(
  (ref) => PomodoroValue(
    workDuration: const Duration(minutes: 45),
    breakDuration: const Duration(minutes: 15),
  ),
);
