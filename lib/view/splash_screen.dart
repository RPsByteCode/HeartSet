import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mhc/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _fadeAnim  = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeIn));
    _scaleAnim = Tween<double>(begin: 0.7, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _ctrl.forward();

    // Navigate to login after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) Get.off(() => const LoginScreen(), transition: Transition.fadeIn);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7B32FF),
      body: Center(
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (_, __) => FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 30, spreadRadius: 4),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Image.asset('assets/images/appIcon1.png', fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'MHC',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 4),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Mental Health Companion',
                    style: TextStyle(fontSize: 15, color: Colors.white70, letterSpacing: 1),
                  ),
                  const SizedBox(height: 48),
                  const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(color: Colors.white70, strokeWidth: 2.5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
