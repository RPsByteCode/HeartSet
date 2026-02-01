

import 'package:flutter/material.dart';




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
        return ();
      case 1:
        return ();
      case 2:
        return ();
      
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: "Home",
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.book_outlined),
          //   label: "Dairy",
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.warning_amber),
          //   label: "Support",
          // ),
        ],),
    );
  }
}
