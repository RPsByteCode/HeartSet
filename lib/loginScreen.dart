import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:mhc/selectUserType.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hide = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset("assets/images/appIcon.png", fit: BoxFit.cover,),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Welcome Back",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your Mental Health Journey Continues",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 30),

            Row(
              children: [
                // SizedBox(width: 1,),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: const Text(
                    "Email Address",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text("Enter your email"),
                prefixIcon: Icon(Icons.email_outlined),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue, width: 3),
                ),
              ),
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                // SizedBox(width: 1,),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: const Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              obscureText: hide,
              controller: passwordController,
              decoration: InputDecoration(
                label: Text("Enter your password"),
                prefixIcon: Icon(Icons.lock_outline_sharp),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      hide = !hide;
                    });
                  },
                  child: Icon(Icons.remove_red_eye_outlined),
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue, width: 3),
                ),
              ),
            ),

            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     GestureDetector(
            //       onTap: () {},
            //       child: const Text(
            //         "Forgot Password?",
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.deepPurpleAccent,
            //         ),
            //         textAlign: TextAlign.end,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 50),
            // Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(350, 60)),
                elevation: WidgetStateProperty.resolveWith<double>((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.pressed)) {
                    return 2.0; // Sinks when pressed
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return 8.0; // Rises when hovered
                  }
                  return 5.0; // Default elevation
                }),
                backgroundColor: WidgetStateColor.resolveWith((states) {
                  if (states.contains(WidgetState.pressed)) return Colors.deepPurpleAccent.shade400;
                  if (states.contains(WidgetState.hovered)) return Colors.deepPurpleAccent.shade100;
                  return Colors.deepPurpleAccent;
                }),
              ),
              onPressed: () {},
              child: Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have account?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration( seconds: 1),
                        reverseTransitionDuration: const Duration( seconds: 1),
                        pageBuilder: (context, animation, secondaryAnimation) => const SelectUserTypeScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return SharedAxisTransition(animation: animation, secondaryAnimation: secondaryAnimation, transitionType: SharedAxisTransitionType.horizontal, child: child,);
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
