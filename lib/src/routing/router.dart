import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro_flutter/src/enums/app_route.dart';
import 'package:pomodoro_flutter/src/screens/history.dart';
import 'package:pomodoro_flutter/src/screens/home.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/home',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        pageBuilder: (context, state) =>  MaterialPage(
          child: HomeScreen()
        )
      ),
      GoRoute(
          path: '/history',
          name: AppRoute.history.name,
          pageBuilder: (context, state) =>  MaterialPage(
              child: HistoryScreen()
          ),
      ),
    ],
  );
}
