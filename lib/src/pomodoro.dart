import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/src/routing/router.dart';

class Pomodoro extends ConsumerWidget {
  const Pomodoro({Key? super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

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