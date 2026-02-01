

import 'package:flutter/material.dart';
import 'package:mhc/view/guardian_app/alerts_screen.dart';
import 'package:mhc/view/guardian_app/watch_screen.dart';
import 'package:mhc/view/guardian_app/weekly_update_screen.dart';



class GaurdianNavBar extends StatefulWidget {

  const GaurdianNavBar({super.key});

  @override
  State<GaurdianNavBar> createState() => _NavBarState();
}

class _NavBarState extends State<GaurdianNavBar> {
  int currentPage = 0;

  pages(int currentPage) {
    switch (currentPage) {
      case 0:
        return GuardianModeScreen();
      case 1:
        return EmergencyAlertScreen();
      case 2:
        return WeeklyMoodOverviewScreen();
      
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
            icon: Icon(Icons.remove_red_eye_outlined),
            label: "Watch",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_amber),
            label: "Alert",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support),
            label: "Support",
          ),
        ],
      
    )
    );
  }
}
