import 'package:flutter/material.dart';
import 'package:mhc/view/consultant_app/group_screens/group_screen.dart';
import 'package:mhc/view/consultant_app/home_screen.dart';
import 'package:mhc/view/consultant_app/individual_screens/individual_screen.dart';

class ConsultantNavBar extends StatefulWidget {
  const ConsultantNavBar({super.key});

  @override
  State<ConsultantNavBar> createState() => _ConsultantNavBarState();
}

class _ConsultantNavBarState extends State<ConsultantNavBar> {
  int _currentPage = 0;

  Widget _page(int index) {
    switch (index) {
      case 0: return const ConsultantDashboard();
      case 1: return const IndividualScreen();
      case 2: return const GroupScreen();
      default: return const ConsultantDashboard();
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
        backgroundColor: Colors.white,
        elevation: 8,
        onTap: (v) => setState(() => _currentPage = v),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Patients'),
          BottomNavigationBarItem(icon: Icon(Icons.group_outlined), activeIcon: Icon(Icons.group), label: 'Groups'),
        ],
      ),
    );
  }
}
