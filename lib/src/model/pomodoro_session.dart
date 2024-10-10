class PomodoroSession {
  final Duration workDuration;
  final Duration breakDuration;
  final DateTime date;
  final int cycleCount;

  const PomodoroSession({
    required this.workDuration,
    required this.breakDuration,
    required this.date,
    required this.cycleCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'workDuration': workDuration.inSeconds,
      'breakDuration': breakDuration.inSeconds,
      'date': date.toIso8601String(),
      'cycleCount': cycleCount,
    };
  }
}