import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/src/providers/pomodoro_value_provider.dart';
import 'package:quiver/async.dart';

class TimerNotifier extends StateNotifier<Duration> {
  TimerNotifier(this.ref) : super(Duration.zero) {
    durations = ref.read(pomodoroValuesProvider);
  }

  final Ref ref;
  CountdownTimer? _timer;
  late PomodoroValue durations;
  bool isWork = true;

  void startTimer() {
    _timer?.cancel();
    final duration = isWork ? durations.workDuration : durations.breakDuration;
    _timer = CountdownTimer(
      duration,
      const Duration(seconds: 1),
    );

    _timer!.listen((event) {
      state = event.remaining;
    }, onDone: () {
      isWork = !isWork;
      startTimer();
    });
  }


  void cancelTimer() {
    _timer?.cancel();
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