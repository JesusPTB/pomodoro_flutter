import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_flutter/src/model/pomodoro_session.dart';
import 'package:pomodoro_flutter/src/providers/history_provider.dart';
import 'package:pomodoro_flutter/src/utils/format_duration.dart';

import '../common_widgets/navbar.dart';
import '../database_helper.dart';
import '../enums/app_route.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({Key? super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique'),
        actions: [
          IconButton(
              onPressed: () async {
                // await DatabaseHelper().clearSessions();
                ref.refresh(historyProvider);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      bottomNavigationBar: const Navbar(
        currentRoute: AppRoute.history,
      ),
      body: RefreshIndicator(
        child: Consumer(
          builder: (context, watch, child) {
            final sessions = ref.watch(historyProvider).value ?? [];
            final sortedSessions = sessions
              ..sort((a, b) => b.beginDate.compareTo(a.beginDate));
            if (sessions.isEmpty) {
              return const Center(
                child: Text("Aucun historique disponible"),
              );
            }
            return ListView.builder(
              itemCount: sortedSessions.length,
              itemBuilder: (context, index) {
                final session = sortedSessions[index];
                return ListTile(
                  title: Text(
                      'Travail: ${session.focusDuration.inMinutes} minutes, Pause: ${session.relaxDuration.inMinutes} minutes'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Total Travail: ${formatDuration(session.focusedTime)}'),
                      Text(
                          'Total Pause: ${formatDuration(session.relaxedTime)}'),
                      Text('Date début: ${DateFormat().format(session.beginDate)}'),
                      Text('Date fin: ${DateFormat().format(session.endDate)}'),
                      // Text('Date: ${DateFormat.yMMMd().format(session.beginDate)}'),
                      Text('Cycles: ${session.iterationsNumber}'),
                    ],
                  ),
                );
              },
            );
          },
        ),
        onRefresh: () async {
          ref.refresh(historyProvider);
        },
      ),
    );
  }
}
