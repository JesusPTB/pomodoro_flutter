class PomodoroSession {
  final Duration focusDuration;
  final Duration relaxDuration;
  final Duration focusedTime;
  final Duration relaxedTime;
  final DateTime beginDate;
  final DateTime endDate;
  final int iterationsNumber;

  const PomodoroSession({
    required this.focusDuration,
    required this.relaxDuration,
    required this.focusedTime,
    required this.relaxedTime,
    required this.beginDate,
    required this.endDate,
    required this.iterationsNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'focusDuration': focusDuration.inSeconds,
      'relaxDuration': relaxDuration.inSeconds,
      'focusedTime': focusedTime.inSeconds,
      'relaxedTime': relaxedTime.inSeconds,
      'beginDate': beginDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'iterationsNumber': iterationsNumber,
    };
  }
}