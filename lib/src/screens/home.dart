import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/src/common_widgets/navbar.dart';
import 'package:pomodoro_flutter/src/enums/app_route.dart';
import 'package:pomodoro_flutter/src/enums/timer_state.dart';

import '../providers/pomodoro_value_provider.dart';
import '../providers/timer_provider.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingTime = ref.watch(timerProvider);
    final timerNotifier = ref.watch(timerProvider.notifier);
    final isWork = timerNotifier.isWork;
    final durations = ref.read(pomodoroValuesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      bottomNavigationBar: const Navbar(
        currentRoute: AppRoute.home,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(isWork ? 'Travail' : 'Pause', style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    value: 1 - (remainingTime.inSeconds / (isWork ? durations.workDuration.inSeconds : durations.breakDuration.inSeconds)),
                    backgroundColor: Colors.grey,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  "${remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(remainingTime.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
                  style: const TextStyle(fontSize: 50),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SegmentedButton<TimerState>(
              style: SegmentedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.red,
                selectedForegroundColor: Colors.white,
                selectedBackgroundColor: Colors.green,
              ),
              segments: const <ButtonSegment<TimerState>>[
                ButtonSegment<TimerState>(
                  value: TimerState.play,
                  icon: Icon(Icons.play_arrow),
                ),
                ButtonSegment<TimerState>(
                  value: TimerState.pause,
                  icon: Icon(Icons.pause),
                ),
                ButtonSegment<TimerState>(
                  value: TimerState.stop,
                  icon: Icon(Icons.stop),
                ),
              ],
              selected: const {TimerState.stop},
              onSelectionChanged: (selected) {
                if (selected.contains(TimerState.play)) {
                  timerNotifier.startTimer();
                } else if (selected.contains(TimerState.pause)) {
                  timerNotifier.cancelTimer();
                } else if (selected.contains(TimerState.stop)) {
                  timerNotifier.cancelTimer();
                }
              },
              showSelectedIcon: false,
            ),
          ],
        ),
      ),
    );
  }
}
