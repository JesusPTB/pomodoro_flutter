import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common_widgets/navbar.dart';
import '../enums/app_route.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({Key? super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      bottomNavigationBar: const Navbar(
        currentRoute: AppRoute.history,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('History Screen'),
          ],
        ),
      ),
    );
  }
}