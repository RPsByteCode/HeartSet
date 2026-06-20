import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';
import 'package:mhc/selectUserType.dart';
import 'package:mhc/view/consultant_app/consultant_nav_bar.dart';
import 'package:mhc/view/guardian_app/gaurdian_nav_bar.dart';
import 'package:mhc/view/institutional_app/institute_nav_bar.dart';
import 'package:mhc/view/patient_app/patient_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hide = true;
  bool _loading = false;
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();

  // Demo routing: picks destination based on email prefix
  // Replace with real Firebase Auth in the future
  void _handleLogin() {
    final email = _emailCtrl.text.trim().toLowerCase();
    if (email.isEmpty || _passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    setState(() => _loading = true);

    // Simulate a short auth delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() => _loading = false);

      Widget destination;
      if (email.contains('consultant') || email.contains('doctor')) {
        destination = const ConsultantNavBar();
      } else if (email.contains('guardian')) {
        destination = const GaurdianNavBar();
      } else if (email.contains('institute') || email.contains('admin')) {
        destination = const InstituteNavBar();
      } else {
        destination = const PatientNavBar();
      }

      Get.off(() => destination, transition: Transition.fadeIn);
    });
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // App icon
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/appIcon.png', fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Welcome Back', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Your Mental Health Journey Continues', style: TextStyle(fontSize: 15, color: Colors.grey)),
              const SizedBox(height: 36),

              // Email
              _label('Email Address'),
              _textField(_emailCtrl, 'Enter your email', Icons.email_outlined),
              const SizedBox(height: 16),

              // Password
              _label('Password'),
              TextField(
                controller: _passwordCtrl,
                obscureText: _hide,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_hide ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: () => setState(() => _hide = !_hide),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF7B32FF), width: 2.5),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B32FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                  ),
                  onPressed: _loading ? null : _handleLogin,
                  child: _loading
                      ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                      : const Text('LOGIN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 24),

              // Sign up redirect
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?", style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 700),
                        reverseTransitionDuration: const Duration(milliseconds: 700),
                        pageBuilder: (_, a, b) => const SelectUserTypeScreen(),
                        transitionsBuilder: (_, a, b, child) => SharedAxisTransition(
                          animation: a, secondaryAnimation: b,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        ),
                      ),
                    ),
                    child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7B32FF))),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              // Quick demo hint
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '💡 Demo: Use "consultant@", "guardian@", "institute@" or any email to enter as Patient',
                  style: TextStyle(fontSize: 11, color: Colors.blueGrey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
    ),
  );

  Widget _textField(TextEditingController ctrl, String hint, IconData icon) => TextField(
    controller: ctrl,
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.grey, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF7B32FF), width: 2.5),
      ),
    ),
  );
}
