import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/src/database_helper.dart';
import 'package:pomodoro_flutter/src/enums/timer_state.dart';
import 'package:pomodoro_flutter/src/providers/auth_provider.dart';
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
  TimerState timerState = TimerState.stop;
  late DateTime beginDate = DateTime.now();
  late DateTime endDate = DateTime.now();

  void startTimer() {
    _timer?.cancel();
    final duration = isWork ? durations.workDuration : durations.breakDuration;
    state = duration;
    beginDate = DateTime.now();

    _timer = CountdownTimer(
      duration,
      const Duration(milliseconds: 1000),
    );
    state = duration - const Duration(seconds: 1);
    timerState = TimerState.play;
    _timer!.listen((event) {
      state = event.remaining;
    }, onDone: () async {

      if (timerState == TimerState.pause) {
        print("pause");
        return;
      }
      if (reset) {
        reset = false;
        isWork = true;
        state = durations.workDuration;
        return;
      } else {
        notifyEnd(isWork);
        if (!isWork) {
          cycleCount++;
        }
        isWork = !isWork;
        _timer?.cancel();
        startTimer();
      }
    });
  }

  void pauseTimer() {
    if (timerState == TimerState.play) {
      timerState = TimerState.pause;
      _timer?.cancel();
    }
  }

  void resumeTimer() {
    if (timerState == TimerState.pause) {
      final remaining = state;
      _timer = CountdownTimer(
        remaining,
        const Duration(milliseconds: 1000),
      );
      timerState = TimerState.play;
      _timer!.listen((event) {
        state = event.remaining;
      }, onDone: () async {

        if (timerState == TimerState.pause) {
          print("pause");
          return;
        }
        if (reset) {
          reset = false;
          isWork = true;
          state = durations.workDuration;
          return;
        } else {
          notifyEnd(isWork);
          if (!isWork) {
            cycleCount++;
          }
          isWork = !isWork;
          startTimer();
        }
      });
    }
  }

  void notifyEnd(bool isWork) async{
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: 'Pomodoro',
          body: isWork ? "C'est l'heure de la pause !" : 'Au travail !',
        )
    );
    await player.play(AssetSource('bell.mp3'));
  }

  void cancelTimer() {
    reset = true;
    timerState = TimerState.stop;
    _timer?.cancel();
    endDate = DateTime.now();
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
    final db = FirebaseFirestore.instance;
    final user = ref.read(authProvider.notifier).user;
    if (totalWorkDuration.inSeconds == 0 && totalBreakDuration.inSeconds == 0) {
      return;
    }
    db.collection("sessions").add({
      "focusDuration": durations.workDuration.inSeconds,
      "relaxDuration": durations.breakDuration.inSeconds,
      "focusedTime": totalWorkDuration.inSeconds,
      "relaxedTime": totalBreakDuration.inSeconds,
      "iterationsNumber": cycleCount,
      "userEmail": user?.email,
      "beginDate": beginDate,
      "endDate": endDate,
    });
    // dbHelper.insertSession(PomodoroSession(
    //   focusDuration: durations.workDuration,
    //   relaxDuration: durations.breakDuration,
    //   relaxedTime: totalBreakDuration,
    //   focusedTime: totalWorkDuration,
    //   date: DateTime.now(),
    //   iterationsNumber: cycleCount,
    // ));
    // ref.refresh(historyProvider); //@todo: peut etre refresh quand on arrive sur l'onglet historique pour opti

    cycleCount = 1;
    // state = Duration.zero;
  }

  @override
  void dispose() {
    _timer?.cancel();
    player.dispose();
    timerState = TimerState.stop;
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
