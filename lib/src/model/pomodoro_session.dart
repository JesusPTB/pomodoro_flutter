class PomodoroSession {
  final Duration workDuration;
  final Duration breakDuration;
  final Duration totalWorkDuration;
  final Duration totalBreakDuration;
  final DateTime date;
  final int cycleCount;

  const PomodoroSession({
    required this.workDuration,
    required this.breakDuration,
    required this.totalWorkDuration,
    required this.totalBreakDuration,
    required this.date,
    required this.cycleCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'workDuration': workDuration.inSeconds,
      'breakDuration': breakDuration.inSeconds,
      'totalWorkDuration': totalWorkDuration.inSeconds,
      'totalBreakDuration': totalBreakDuration.inSeconds,
      'date': date.toIso8601String(),
      'cycleCount': cycleCount,
    };
  }
}