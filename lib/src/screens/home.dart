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
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: const Navbar(
        currentRoute: AppRoute.home,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // const SizedBox(height: 200),
                  Text(
                      "Durée de travail: ${durations.workDuration.inMinutes} minutes, durée de pause: ${durations.breakDuration.inMinutes} minutes"),
                  Text(isWork ? 'Travail' : 'Pause',
                      style: const TextStyle(fontSize: 30)),
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CircularProgressIndicator(
                          value: 1 -
                              (remainingTime.inSeconds /
                                  (isWork
                                      ? durations.workDuration.inSeconds
                                      : durations.breakDuration.inSeconds)),
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
                  ElevatedButton(
                      onPressed: timerNotifier.startTimer,
                      child: const Text('Start')),
                  ElevatedButton(
                      onPressed: timerNotifier.cancelTimer,
                      child: const Text('Stop')),
                  const SizedBox(height: 20),
                  Text('Cycle complétés: ${timerNotifier.cycleCount}'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
