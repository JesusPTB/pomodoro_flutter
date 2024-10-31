import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro_flutter/src/enums/app_route.dart';
import 'package:pomodoro_flutter/src/providers/auth_provider.dart';
import 'package:pomodoro_flutter/src/routing/go_router_refresh_stream.dart';
import 'package:pomodoro_flutter/src/screens/history.dart';
import 'package:pomodoro_flutter/src/screens/home.dart';
import 'package:pomodoro_flutter/src/screens/settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/user_notifier_provider.dart';
import '../screens/login.dart';

part 'router.g.dart';

final routerKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final auth = ref.watch(authProvider.notifier);

  return GoRouter(
    navigatorKey: routerKey,
    initialLocation: '/login',
    refreshListenable: auth,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final isLogged = auth.isAuthenticated;

      if (state.uri.path == '/login' && isLogged) {
        return '/home';
      } else if (state.uri.path != '/login' && !isLogged) {
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        pageBuilder: (context, state) => MaterialPage(
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        pageBuilder: (context, state) => MaterialPage(child: HomeScreen()),
      ),
      GoRoute(
        path: '/history',
        name: AppRoute.history.name,
        pageBuilder: (context, state) => MaterialPage(child: HistoryScreen()),
      ),
      GoRoute(
        path: '/settings',
        name: AppRoute.settings.name,
        pageBuilder: (context, state) => MaterialPage(child: SettingsScreen()),
      ),
    ],
  );
}
