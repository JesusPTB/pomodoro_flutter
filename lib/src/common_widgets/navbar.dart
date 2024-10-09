import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro_flutter/src/routing/router.dart';

import '../enums/app_route.dart';

class Destination {
  final String label;
  final Widget icon;
  final Widget selectedIcon;
  final AppRoute route;

  const Destination(this.label, this.icon, this.selectedIcon, this.route);
}

const List<Destination> destinations = <Destination>[
  Destination(
    'Accueil',
    Icon(Icons.home),
    Icon(Icons.home),
    AppRoute.home,
  ),
  Destination(
    'Historique',
    Icon(Icons.history),
    Icon(Icons.history),
    AppRoute.history,
  ),
];

class Navbar extends ConsumerStatefulWidget {
  const Navbar({super.key, required this.currentRoute});

  final AppRoute currentRoute;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavbarState();
}

class _NavbarState extends ConsumerState<Navbar> {
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    int selectedIndex = destinations
        .indexWhere((element) => element.route == widget.currentRoute);

    return NavigationBar(
      selectedIndex: selectedIndex,
      labelBehavior: labelBehavior,
      onDestinationSelected: (int index) {
        context.goNamed(destinations[index].route.name);
      },
      destinations: <Widget>[
        ...destinations.map(
          (Destination destination) {
            return NavigationDestination(
              label: destination.label,
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
            );
          },
        ),
      ],
    );
  }
}
