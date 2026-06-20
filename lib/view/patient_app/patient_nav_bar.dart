import 'package:flutter/material.dart';
import 'package:mhc/view/patient_app/home_screen.dart';
import 'package:mhc/view/patient_app/dairy_screen.dart';
import 'package:mhc/view/patient_app/support_screen.dart';

class PatientNavBar extends StatefulWidget {
  const PatientNavBar({super.key});

  @override
  State<PatientNavBar> createState() => _PatientNavBarState();
}

class _PatientNavBarState extends State<PatientNavBar> {
  int _currentPage = 0;

  Widget _page(int index) {
    switch (index) {
      case 0: return const HomeScreen();
      case 1: return const DiaryScreen();
      case 2: return const SupportScreen();
      default: return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page(_currentPage),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        selectedItemColor: const Color(0xFF7B32FF),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        onTap: (v) => setState(() => _currentPage = v),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), activeIcon: Icon(Icons.book), label: 'Diary'),
          BottomNavigationBarItem(icon: Icon(Icons.support_outlined), activeIcon: Icon(Icons.support), label: 'Support'),
        ],
      ),
    );
  }
}
