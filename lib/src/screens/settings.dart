import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/src/providers/history_provider.dart';

import '../common_widgets/navbar.dart';
import '../database_helper.dart';
import '../enums/app_route.dart';
import '../providers/auth_provider.dart';
import '../providers/pomodoro_value_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider.notifier);
    final user = auth.user;
    final pomodoroValues = ref.watch(pomodoroValuesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        actions: [
          IconButton(
              onPressed: () async {
                await auth.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: const Navbar(
        currentRoute: AppRoute.settings,
      ),
      body: Column(
        children: <Widget>[
          //User
          ListTile(
            title: Text('Utilisateur: ${user?.email}'),
          ),
          //3 Buttons to change pomodoro values
          ElevatedButton(
            onPressed: pomodoroValues.setShortPomodoro,
            child: const Text('Pomodoro court: 25/5'),
          ),
          ElevatedButton(
            onPressed: pomodoroValues.setLongPomodoro,
            child: const Text('Pomodoro moyen: 45/15'),
          ),
          ElevatedButton(
            onPressed: pomodoroValues.setTestPomodoro,
            child: const Text('Pomodoro test: 25s/5s'),
          ),
        ],
      ),
    );
  }
}
