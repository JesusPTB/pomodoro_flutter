//
// import 'package:flip_board/flip_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../providers/pomodoro_value_provider.dart';
// import '../providers/timer_provider.dart';
//
// class MyClock extends ConsumerWidget {
//   MyClock({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final remainingTime = ref.watch(timerProvider);
//     final timerNotifier = ref.watch(timerProvider.notifier);
//     final isWork = timerNotifier.isWork;
//     final durations = ref.read(pomodoroValuesProvider);
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         firstMinuteDigit(isWork, durations, timerNotifier),
//         lastMinuteDigit(isWork, durations, timerNotifier),
//         const SizedBox(width: 10, child: Text(":")),
//         firstSecondDigit(isWork, durations, timerNotifier),
//         lastSecondDigit(isWork, durations, timerNotifier),
//       ],
//     );
//
//   }
// }
//
// firstMinuteDigit(bool isWork, PomodoroValue durations, timerNotifier) {
//   return FlipWidget(
//     initialValue: isWork
//         ? durations.workDuration
//         : durations.breakDuration,
//     flipType: FlipType.middleFlip,
//     itemStream: timerNotifier.stream,
//     itemBuilder: (context, index) {
//       if (index == null) {
//         if (isWork) {
//           return Text(
//               (durations.workDuration.inMinutes ~/ 10).toString(),
//               style: const TextStyle(
//                   fontSize: 100, color: Colors.white));
//         } else {
//           return Text(
//               (durations.breakDuration.inMinutes~/ 10).toString(),
//               style: const TextStyle(
//                   fontSize: 100, color: Colors.white));
//         }
//       } else {
//         return Text(
//             ((index.inMinutes ~/ 10) % 6).toString(),
//             style: const TextStyle(fontSize: 100, color: Colors.white, backgroundColor: Colors.black));
//       }
//     },
//     flipDirection: AxisDirection.down,
//     flipDuration: const Duration(milliseconds: 1000),
//     flipCurve: FlipWidget.defaultFlip,
//     perspectiveEffect: 0.006,
//     hingeWidth: 2.0,
//     hingeLength: 56.0,
//     // hingeColor: Colors.black,
//   );
// }
// lastMinuteDigit(bool isWork, PomodoroValue durations, timerNotifier) {
//   return        FlipWidget(
//     initialValue: isWork
//         ? durations.workDuration
//         : durations.breakDuration,
//     flipType: FlipType.middleFlip,
//     itemStream: timerNotifier.stream,
//     itemBuilder: (context, index) {
//       if (index == null) {
//         if (isWork) {
//           return Text(
//               (durations.workDuration.inMinutes.remainder(10)).toString(),
//               style: const TextStyle(
//                   fontSize: 100, color: Colors.white));
//         } else {
//           return Text(
//               (durations.breakDuration.inMinutes.remainder(10)).toString(),
//               style: const TextStyle(
//                   fontSize: 100, color: Colors.white));
//         }
//       } else {
//         return Text(
//             (index.inMinutes.remainder(10)).toString(),
//             style: const TextStyle(fontSize: 100, color: Colors.white, backgroundColor: Colors.black));
//       }
//     },
//     flipDirection: AxisDirection.down,
//     flipDuration: const Duration(milliseconds: 1000),
//     flipCurve: FlipWidget.defaultFlip,
//     perspectiveEffect: 0.006,
//     hingeWidth: 2.0,
//     hingeLength: 56.0,
//     // hingeColor: Colors.black,
//   );
// }
//
// firstSecondDigit(bool isWork, PomodoroValue durations, timerNotifier) {
//   return FlipWidget(
//     initialValue: isWork
//         ? durations.workDuration
//         : durations.breakDuration,
//     flipType: FlipType.middleFlip,
//     itemStream: timerNotifier.stream,
//     itemBuilder: (context, index) {
//       if (index == null) {
//         if (isWork) {
//           return Text(
//               (durations.workDuration.inSeconds ~/ 10).toString(),
//               style: const TextStyle(
//                   fontSize: 100, color: Colors.white));
//         } else {
//           return Text(
//               (durations.breakDuration.inSeconds ~/ 10).toString(),
//               style: const TextStyle(
//                   fontSize: 100, color: Colors.white));
//         }
//       } else {
//         return Text(
//             ((index.inSeconds ~/ 10) % 6).toString(),
//             style: const TextStyle(fontSize: 100, color: Colors.white, backgroundColor: Colors.black));
//       }
//     },
//     flipDirection: AxisDirection.down,
//     flipDuration: const Duration(milliseconds: 1000),
//     flipCurve: FlipWidget.defaultFlip,
//     perspectiveEffect: 0.006,
//     hingeWidth: 2.0,
//     hingeLength: 56.0,
//     // hingeColor: Colors.black,
//   );
// }
//
// lastSecondDigit(bool isWork, PomodoroValue durations, timerNotifier) {
//   return FlipWidget(
//     initialValue: isWork
//         ? durations.workDuration
//         : durations.breakDuration,
//     flipType: FlipType.middleFlip,
//     itemStream: timerNotifier.stream,
//     itemBuilder: (context, index) {
//       if (index == null) {
//         if (isWork) {
//           return Text(
//               (durations.workDuration.inSeconds.remainder(10)).toString(),
//               style: const TextStyle(
//                   fontSize: 100, color: Colors.white));
//         } else {
//           return Text(
//               (durations.breakDuration.inSeconds.remainder(10)).toString(),
//               style: const TextStyle(
//                   fontSize: 100, color: Colors.white));
//         }
//       } else {
//         return Text(
//             (index.inSeconds.remainder(10)).toString(),
//             style: const TextStyle(fontSize: 100, color: Colors.white, backgroundColor: Colors.black));
//       }
//     },
//     flipDirection: AxisDirection.down,
//     flipDuration: const Duration(milliseconds: 1000),
//     flipCurve: FlipWidget.defaultFlip,
//     perspectiveEffect: 0.006,
//     hingeWidth: 2.0,
//     hingeLength: 56.0,
//     // hingeColor: Colors.black,
//   );
// }

import 'package:flip_board/flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pomodoro_value_provider.dart';
import '../providers/timer_provider.dart';

class MyClock extends ConsumerWidget {
  const MyClock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingTime = ref.watch(timerProvider);
    final timerNotifier = ref.watch(timerProvider.notifier);
    final isWork = timerNotifier.isWork;
    final durations = ref.read(pomodoroValuesProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MinuteDigit(
          digit: remainingTime.inMinutes ~/ 10,
          isWork: isWork,
          durations: durations,
          timerNotifier: timerNotifier,
        ),
        MinuteDigit(
          digit: remainingTime.inMinutes % 10,
          isWork: isWork,
          durations: durations,
          timerNotifier: timerNotifier,
        ),
        const SizedBox(width: 10, child: Text(":")),
        Second1Digit(
          digit: (remainingTime.inSeconds % 60) ~/ 10,
          isWork: isWork,
          durations: durations,
          timerNotifier: timerNotifier,
        ),
        Second2Digit(
          digit: remainingTime.inSeconds.remainder(10),
          isWork: isWork,
          durations: durations,
          timerNotifier: timerNotifier,
        ),
      ],
    );
  }
}

class MinuteDigit extends StatelessWidget {
  final int digit;
  final bool isWork;
  final PomodoroValue durations;
  final TimerNotifier timerNotifier;

  const MinuteDigit({
    Key? key,
    required this.digit,
    required this.isWork,
    required this.durations,
    required this.timerNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipWidget(
      key: ValueKey('minute_$digit'),
      initialValue: digit,
      flipType: FlipType.middleFlip,
      itemStream: timerNotifier.stream.map((duration) => duration.inMinutes),
      itemBuilder: (context, value) {
        return Text(
          digit.toString(),
          style: const TextStyle(fontSize: 100, color: Colors.white, backgroundColor: Colors.black),
        );
      },
      flipDirection: AxisDirection.down,
      flipDuration: const Duration(milliseconds: 500),
      flipCurve: FlipWidget.defaultFlip,
      perspectiveEffect: 0.006,
      hingeWidth: 2.0,
      hingeLength: 56.0,
    );
  }
}

class Second1Digit extends StatelessWidget {
  final int digit;
  final bool isWork;
  final PomodoroValue durations;
  final TimerNotifier timerNotifier;

  const Second1Digit({
    Key? key,
    required this.digit,
    required this.isWork,
    required this.durations,
    required this.timerNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipWidget(
      key: ValueKey('second1_$digit'),
      initialValue: digit,
      flipType: FlipType.middleFlip,
      itemStream: timerNotifier.stream.map((duration) => duration.inSeconds % 60),
      itemBuilder: (context, value) {
        return Text(
          digit.toString(),
          style: const TextStyle(fontSize: 100, color: Colors.white, backgroundColor: Colors.black),
        );
      },
      flipDirection: AxisDirection.down,
      flipDuration: const Duration(milliseconds: 500),
      flipCurve: FlipWidget.defaultFlip,
      perspectiveEffect: 0.006,
      hingeWidth: 2.0,
      hingeLength: 56.0,
    );
  }
}
class Second2Digit extends StatelessWidget {
  final int digit;
  final bool isWork;
  final PomodoroValue durations;
  final TimerNotifier timerNotifier;

  const Second2Digit({
    Key? key,
    required this.digit,
    required this.isWork,
    required this.durations,
    required this.timerNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipWidget(
      key: ValueKey('second2_$digit'),
      initialValue: digit,
      flipType: FlipType.middleFlip,
      itemStream: timerNotifier.stream.map((duration) => duration.inSeconds % 60),
      itemBuilder: (context, value) {
        return Text(
          digit.toString(),
          style: const TextStyle(fontSize: 100, color: Colors.white, backgroundColor: Colors.black),
        );
      },
      flipDirection: AxisDirection.down,
      flipDuration: const Duration(milliseconds: 500),
      flipCurve: FlipWidget.defaultFlip,
      perspectiveEffect: 0.006,
      hingeWidth: 2.0,
      hingeLength: 56.0,
    );
  }
}