import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/src/providers/history_provider.dart';

import '../common_widgets/navbar.dart';
import '../database_helper.dart';
import '../enums/app_route.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        actions: [
          IconButton(
              onPressed: () async {
                await DatabaseHelper().clearSessions();
                ref.refresh(historyProvider);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      bottomNavigationBar: const Navbar(
        currentRoute: AppRoute.settings,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          const Text("Durée de travail"),
          const SizedBox(height: 20),
          const Text("Durée de pause"),
          const SizedBox(height: 20),
          const Text("Nombre de cycles"),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
