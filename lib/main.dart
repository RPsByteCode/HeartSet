import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mhc/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyD6jC3nrcp1NWjhcQT3BYqoRPq4imDY2XE',
      appId: '1:566189193301:android:d0323f8b2a43edced67cdc',
      messagingSenderId: '566189193301',
      projectId: 'heartset-b0f3f',
    ),
  );
  runApp(const MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}