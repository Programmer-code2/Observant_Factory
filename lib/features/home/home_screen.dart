import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/locale_provider.dart';
import '../places/places_screen.dart';
import '../reports/report_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../observations/observations_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  final _screens = const [
    PlacesScreen(),
    ReportScreen(),
    DashboardScreen(),
    ObservationsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(stringsProvider);
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.business_outlined),
            selectedIcon: const Icon(Icons.business),
            label: strings.navPlaces,
          ),
          NavigationDestination(
            icon: const Icon(Icons.assessment_outlined),
            selectedIcon: const Icon(Icons.assessment),
            label: strings.navReports,
          ),
          NavigationDestination(
            icon: const Icon(Icons.bar_chart_outlined),
            selectedIcon: const Icon(Icons.bar_chart),
            label: strings.navDashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.list_alt_outlined),
            selectedIcon: const Icon(Icons.list_alt),
            label: strings.navObservations,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: strings.navSettings,
          ),
        ],
      ),
    );
  }
}
