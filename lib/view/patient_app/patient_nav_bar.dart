

import 'package:flutter/material.dart';
import 'package:mhc/view/patient_app/home_screen.dart';
import 'package:mhc/view/patient_app/dairy_screen.dart';
import 'package:mhc/view/patient_app/support_screen.dart';


class PatientNavBar extends StatefulWidget {

  const PatientNavBar({super.key});

  @override
  State<PatientNavBar> createState() => _NavBarState();
}

class _NavBarState extends State<PatientNavBar> {
  int currentPage = 0;

  pages(int currentPage) {
    switch (currentPage) {
      case 0:
        return HomeScreen();
      case 1:
        return DiaryScreen();
      case 2:
        return SupportScreen();
      
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
