import 'package:flutter/material.dart';
import 'package:mhc/view/guardian_app/alerts_screen.dart';
import 'package:mhc/view/guardian_app/watch_screen.dart';
import 'package:mhc/view/guardian_app/weekly_update_screen.dart';

class GaurdianNavBar extends StatefulWidget {
  const GaurdianNavBar({super.key});

  @override
  State<GaurdianNavBar> createState() => _GaurdianNavBarState();
}

class _GaurdianNavBarState extends State<GaurdianNavBar> {
  int _currentPage = 0;

  Widget _page(int index) {
    switch (index) {
      case 0: return const GuardianModeScreen();
      case 1: return const WeeklyMoodOverviewScreen();
      case 2: return const EmergencyAlertScreen();
      default: return const GuardianModeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page(_currentPage),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        selectedItemColor: const Color(0xFF10B981),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        onTap: (v) => setState(() => _currentPage = v),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.remove_red_eye_outlined), activeIcon: Icon(Icons.remove_red_eye), label: 'Watch'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), activeIcon: Icon(Icons.bar_chart), label: 'Mood'),
          BottomNavigationBarItem(icon: Icon(Icons.warning_amber_outlined), activeIcon: Icon(Icons.warning_amber), label: 'Alert'),
        ],
      ),
    );
  }
}
