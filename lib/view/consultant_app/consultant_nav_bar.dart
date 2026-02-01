

import 'package:flutter/material.dart';
import 'package:mhc/view/consultant_app/group_screen.dart';
import 'package:mhc/view/consultant_app/home_screen.dart';
import 'package:mhc/view/consultant_app/individual_screen.dart';



class ConsultantNavBar extends StatefulWidget {

  const ConsultantNavBar({super.key});

  @override
  State<ConsultantNavBar> createState() => _NavBarState();
}

class _NavBarState extends State<ConsultantNavBar> {
  int currentPage = 0;

  pages(int currentPage) {
    switch (currentPage) {
      case 0:
        return ConsultantDashboard();
      case 1:
        return IndividualScreen();
      case 2:
        return GroupScreen();
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages(currentPage),
      bottomNavigationBar:  BottomNavigationBar(
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
            icon: Icon(Icons.person_2_outlined),
            label: "Individuals",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: "Groups",
          ),
        ],
      
    ),
    );
  }
}
