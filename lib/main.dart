

import 'package:flutter/material.dart';
import 'package:mhc/view/patient_app/home_screen.dart';


void main(){
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      // home: Scaffold(
      //   body: HomeScreen(),
      //   bottomNavigationBar:NavBar()
      // ),
      
    );
  }
}