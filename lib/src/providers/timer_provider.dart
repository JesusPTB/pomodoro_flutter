import 'package:audioplayers/audioplayers.dart';
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

  int cycleCount = 1;
  final Ref ref;
  final player = AudioPlayer();
  CountdownTimer? _timer;
  late PomodoroValue durations;
  bool isWork = true;
  bool reset = false;
  bool isRunning = false;

  void startTimer() {
    _timer?.cancel();
    final duration = isWork ? durations.workDuration : durations.breakDuration;
    state = duration;

    _timer = CountdownTimer(
      duration,
      const Duration(milliseconds: 1000),
    );
    state = duration - const Duration(seconds: 1);
    isRunning = true;
    _timer!.listen((event) {
      state = event.remaining;
    }, onDone: () async {

      if (reset) {
        reset = false;
        isWork = true;
        state = durations.workDuration;
        return;
      } else {
        await player.play(AssetSource('bell.mp3'));
        if (!isWork) {
          cycleCount++;
        }
        isWork = !isWork;
        startTimer();
      }
    });
  }


  void cancelTimer() {
    reset = true;
    isRunning = false;
    _timer?.cancel();
    final dbHelper = DatabaseHelper();
    Duration totalWorkDuration = Duration.zero;
    Duration totalBreakDuration = Duration.zero;

    if (isWork) {
      totalWorkDuration = (durations.workDuration * cycleCount) - _timer!.remaining;
      totalBreakDuration = durations.breakDuration * (cycleCount - 1);
    } else {
      totalWorkDuration = durations.workDuration * cycleCount;
      totalBreakDuration = durations.breakDuration * cycleCount - _timer!.remaining;
    }
    print(_timer!.remaining);
    print(durations.breakDuration);
    print(durations.breakDuration * cycleCount);
    print(totalBreakDuration);
    dbHelper.insertSession(PomodoroSession(
      workDuration: durations.workDuration,
      breakDuration: durations.breakDuration,
      totalBreakDuration: totalBreakDuration,
      totalWorkDuration: totalWorkDuration,
      date: DateTime.now(),
      cycleCount: cycleCount,
    ));
    ref.refresh(historyProvider); //@todo: peut etre refresh quand on arrive sur l'onglet historique pour opti

    cycleCount = 1;
    // state = Duration.zero;
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

final timerStreamProvider = StreamProvider.autoDispose<Duration>((ref) {
  final timer = ref.watch(timerProvider);
  return Stream.periodic(const Duration(milliseconds: 100), (x) => x)
      .map((event) => timer);
});