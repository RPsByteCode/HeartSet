

import 'package:flutter/material.dart';
import 'package:mhc/view/consultant_app/consultant_nav_bar.dart';
import 'package:mhc/view/guardian_app/gaurdian_nav_bar.dart';
import 'package:mhc/view/patient_app/patient_nav_bar.dart';



class TestScreen extends StatefulWidget {

  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _NavBarState();
}

class _NavBarState extends State<TestScreen> {
  int currentPage = 0;

  pages(int currentPage) {
    switch (currentPage) {
      case 0:
        return PatientNavBar();
      case 1:
        return ConsultantNavBar();
      case 2:
        return GaurdianNavBar();
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages(currentPage),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          currentPage = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: "Dairy",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_amber),
            label: "Support",
          ),
        ],
      
    ),
    );
  }
}
