import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/src/routing/router.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:pomodoro_flutter/src/utils/notification_controller.dart';

// class Pomodoro extends ConsumerWidget {
//   const Pomodoro({Key? super.key});
//
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final goRouter = ref.watch(goRouterProvider);
//
//     return MaterialApp.router(
//       routerConfig: goRouter,
//       debugShowCheckedModeBanner: false,
//       restorationScopeId: 'pomodoro',
//       onGenerateTitle: (context) => 'Pomodoro',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//     );
//
//   }
// }

class Pomodoro extends ConsumerStatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  PomodoroState createState() => PomodoroState();
}

class PomodoroState extends ConsumerState<Pomodoro> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = ref.watch(goRouterProvider);

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'pomodoro',
      onGenerateTitle: (context) => 'Pomodoro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}