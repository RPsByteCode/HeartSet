import 'package:flutter/material.dart';
import 'package:mhc/view/institutional_app/cohort_orchestrator_screen.dart';
import 'package:mhc/view/institutional_app/institute_home_screen.dart';
import 'package:mhc/view/consultant_app/group_screens/group_list.dart';

class InstituteNavBar extends StatefulWidget {
  const InstituteNavBar({super.key});

  @override
  State<InstituteNavBar> createState() => _InstituteNavBarState();
}

class _InstituteNavBarState extends State<InstituteNavBar> {
  int _currentPage = 0;

  Widget _page(int index) {
    switch (index) {
      case 0: return const InstituteHomeScreen();
      case 1: return const CohortOrchestratorScreen();
      case 2: return const GroupsListScreen();
      default: return const InstituteHomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page(_currentPage),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        selectedItemColor: const Color(0xFF006064),
        unselectedItemColor: Colors.grey,
        onTap: (v) => setState(() => _currentPage = v),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Cohorts'),
          BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'Groups'),
        ],
      ),
    );
  }
}
