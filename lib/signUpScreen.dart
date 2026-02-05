import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mhc/controller/user_Controller.dart';
import 'package:mhc/testScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool hide = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();

  // Keys match the Enum names for easier mapping
  final Map<String, List<String>> userData = {
    "patient": ["Age", "Emergency Contact"],
    "consultant": ["Specialization", "Years Of Experience", "Consultation Fees"],
    "guardian": ["Relation To Patient", "Patient Email", "Phone Number"],
    "institute": ["Organization Name", "Address", "Type"]
  };

  Widget userTypeField({required UserType userType}) {
    String key = userType.name;
    List<String> fields = userData[key] ?? ["Field 1", "Field 2"];

    return Column(
      children: [
        // Dynamic Field 1
        _buildLabel(fields[0]),
        _buildTextField(oneController, "Enter ${fields[0]}", Icons.data_saver_on_sharp),
        const SizedBox(height: 10),

        // Dynamic Field 2
        _buildLabel(fields[1]),
        _buildTextField(twoController, "Enter ${fields[1]}", Icons.info_outline),
        const SizedBox(height: 10),

        // Dynamic Field 3 (Conditional)
        if (fields.length > 2) ...[
          _buildLabel(fields[2]),
          _buildTextField(threeController, "Enter ${fields[2]}", Icons.more_horiz),
          const SizedBox(height: 10),
        ],
      ],
    );
  }

  // Helper to keep the build method clean
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? hide : false,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: isPassword 
          ? IconButton(
              icon: Icon(hide ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => hide = !hide),
            ) 
          : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.blue, width: 3),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserType selectedRole = Get.arguments ?? UserType.patient;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                // App Icon
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("assets/images/appIcon.png", 
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.apps, size: 80), 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Create Account", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                const Text("Start Your Path To Wellness Today", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 30),

                // Static Fields
                _buildLabel("Full Name"),
                _buildTextField(nameController, "Enter your name", Icons.person_outline),
                const SizedBox(height: 10),

                // Dynamic Fields based on Role
                userTypeField(userType: selectedRole),

                _buildLabel("Email Address"),
                _buildTextField(emailController, "name@example.com", Icons.email_outlined),
                const SizedBox(height: 10),

                _buildLabel("Password"),
                _buildTextField(passwordController, "Enter your password", Icons.lock_outline_sharp, isPassword: true),
                
                const SizedBox(height: 40),

                // Sign Up Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 5,
                  ),
                  onPressed: () {
                    // Registration Logic
                  },
                  child: const Text(
                    "CREATE ACCOUNT",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 20),
                
                // Login Redirect
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Get.off(
                          () => const TestScreen(),
                          transition: Transition.fadeIn,
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}