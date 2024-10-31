// import 'package:flip_board/flip_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pomodoro_flutter/src/common_widgets/navbar.dart';
// import 'package:pomodoro_flutter/src/enums/app_route.dart';
// import '../enums/timer_state.dart';
// import '../providers/pomodoro_value_provider.dart';
// import '../providers/timer_provider.dart';
//
//
//
// class HomeScreen extends ConsumerWidget {
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final remainingTime = ref.watch(timerProvider);
//     final timerNotifier = ref.watch(timerProvider.notifier);
//     final isWork = timerNotifier.isWork;
//     final durations = ref.read(pomodoroValuesProvider);
//
//     return Scaffold(
//       bottomNavigationBar: const Navbar(
//         currentRoute: AppRoute.home,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(isWork ? 'Travail' : 'Pause',
//                       style: const TextStyle(fontSize: 30)),
//                   const SizedBox(height: 20),
//                   Stack(
//                     alignment: Alignment.center,
//                     children: <Widget>[
//                       SizedBox(
//                         height: 300,
//                         width: 300,
//                         child: CircularProgressIndicator(
//                           value: (remainingTime.inSeconds /
//                               (isWork
//                                   ? durations.workDuration.inSeconds
//                                   : durations.breakDuration.inSeconds)),
//                           backgroundColor: Colors.grey,
//                           color: Colors.yellow,
//                         ),
//                       ),
//                       FlipWidget(
//                         initialValue:
//                             timerNotifier.timerState == TimerState.stop
//                                 ? isWork
//                                     ? durations.workDuration
//                                     : durations.breakDuration
//                                 : remainingTime,
//                         flipType: FlipType.middleFlip,
//                         itemStream: timerNotifier.stream,
//                         itemBuilder: (context, index) {
//                           if (index == null) {
//                             if (isWork) {
//                               return Text(
//                                   "${durations.workDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(durations.workDuration.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
//                                   style: const TextStyle(
//                                       fontSize: 100, color: Colors.white));
//                             } else {
//                               return Text(
//                                   "${durations.breakDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(durations.breakDuration.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
//                                   style: const TextStyle(
//                                       fontSize: 100, color: Colors.white));
//                             }
//                           } else {
//                             return Text(
//                                 "${index.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(index.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
//                                 style: const TextStyle(
//                                     fontSize: 100,
//                                     color: Colors.white,
//                                     backgroundColor: Colors.black));
//                           }
//                         },
//                         flipDirection: AxisDirection.down,
//                         flipDuration: const Duration(milliseconds: 1000),
//                         flipCurve: FlipWidget.bounceFastFlip,
//                         perspectiveEffect: 0.006,
//                         hingeWidth: 2.0,
//                         hingeLength: 156.0,
//                         // hingeColor: Colors.black,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       ElevatedButton(
//                         onPressed: timerNotifier.timerState == TimerState.play
//                             ?
//                         child: Text(timerNotifier.timerState == TimerState.play
//                             ? 'Arrêter'
//                             : 'Démarrer'),
//                       ),
//                     ],
//                   ),
//                   if (timerNotifier.timerState != TimerState.stop) ...[
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: timerNotifier.timerState == TimerState.play
//                           ? timerNotifier.pauseTimer
//                           : timerNotifier.resumeTimer,
//                       child: Text(timerNotifier.timerState == TimerState.play
//                           ? 'Pause'
//                           : 'Reprendre'),
//                     ),
//                   ],
//                   const SizedBox(height: 20),
//                   Text('Cycle complétés: ${timerNotifier.cycleCount}'),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flip_board/flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/src/common_widgets/navbar.dart';
import 'package:pomodoro_flutter/src/enums/app_route.dart';
import '../enums/timer_state.dart';
import '../providers/pomodoro_value_provider.dart';
import '../providers/timer_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final remainingTime = ref.watch(timerProvider);
    final timerNotifier = ref.watch(timerProvider.notifier);
    final isWork = timerNotifier.isWork;
    final durations = ref.read(pomodoroValuesProvider);

    return Scaffold(
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
                  Text(isWork ? 'Travail' : 'Pause',
                      style: const TextStyle(fontSize: 30)),
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: CircularProgressIndicator(
                          value: (remainingTime.inSeconds /
                              (isWork
                                  ? durations.workDuration.inSeconds
                                  : durations.breakDuration.inSeconds)),
                          backgroundColor: Colors.grey,
                          color: Colors.yellow,
                        ),
                      ),
                      FlipWidget(
                        initialValue:
                        timerNotifier.timerState == TimerState.stop
                            ? isWork
                            ? durations.workDuration
                            : durations.breakDuration
                            : remainingTime,
                        flipType: FlipType.middleFlip,
                        itemStream: timerNotifier.stream,
                        itemBuilder: (context, index) {
                          if (index == null) {
                            if (isWork) {
                              return Text(
                                  "${durations.workDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(durations.workDuration.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                      fontSize: 100, color: Colors.white));
                            } else {
                              return Text(
                                  "${durations.breakDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(durations.breakDuration.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                      fontSize: 100, color: Colors.white));
                            }
                          } else {
                            return Text(
                                "${index.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(index.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
                                style: const TextStyle(
                                    fontSize: 100,
                                    color: Colors.white,
                                    backgroundColor: Colors.black));
                          }
                        },
                        flipDirection: AxisDirection.down,
                        flipDuration: const Duration(milliseconds: 1000),
                        flipCurve: FlipWidget.bounceFastFlip,
                        perspectiveEffect: 0.006,
                        hingeWidth: 2.0,
                        hingeLength: 156.0,
                        // hingeColor: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: timerNotifier.timerState == TimerState.play
                            ? () {
                          setState(() {
                            timerNotifier.cancelTimer();
                          });
                        }
                            : () {
                          setState(() {
                            timerNotifier.startTimer();
                          });
                        },
                        child: Text(timerNotifier.timerState == TimerState.play
                            ? 'Arrêter'
                            : 'Démarrer'),
                      ),
                    ],
                  ),
                  if (timerNotifier.timerState != TimerState.stop) ...[
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: timerNotifier.timerState == TimerState.play
                          ? () {
                        setState(() {
                          timerNotifier.pauseTimer();
                        });
                      }
                          : () {
                        setState(() {
                          timerNotifier.resumeTimer();
                        });
                      },
                      child: Text(timerNotifier.timerState == TimerState.play
                          ? 'Pause'
                          : 'Reprendre'),
                    ),
                  ],
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