import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mhc/modal/diary_modal/diary_notes.dart';
import 'package:mhc/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Warm up the diary DB so it's ready before the screen opens
  await DiaryNotes.instance.database;

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD6jC3nrcp1NWjhcQT3BYqoRPq4imDY2XE',
      appId: '1:566189193301:android:d0323f8b2a43edced67cdc',
      messagingSenderId: '566189193301',
      projectId: 'heartset-b0f3f',
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MHC',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF7B32FF),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
