import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:mhc/loginScreen.dart';

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

  Map userData = {
    "Patient":["Age","Emergency Contact"],
    "Consultant":["Specialization", "Years Of Experience","Consultation Fees"],
    "Gaurdian":["Relation To Patient", "Patient Email", "Phone Number"],
    "Institute":["Organization Name", "Address", "Type"]
  };

  Widget userTypeField({required String userType}){
    List fields = userData[userType];
    return Column(
      children: [
        Row(
          children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  "${userData[userType][0]}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          ),
          TextField(
          controller: oneController,
          decoration: InputDecoration(
            label: Text("Enter data"),
            prefixIcon: Icon(Icons.data_saver_on_sharp),

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
                child: Text(
                  "${userData[userType][1]}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          ),
          TextField(
          controller: twoController,
          decoration: InputDecoration(
            label: Text("Enter data"),
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

        if(userType!="Patient" && fields.length>2) 
        Column(
          children: [
            Row(
            children: [
              // SizedBox(width: 1,),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  "${userData[userType][2]}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          ),
          TextField(
            controller: threeController,
            decoration: InputDecoration(
            label: Text("Enter data"),
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
          ],
        )
      ],
    );            
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
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
                    child: Image.asset("appIcon.jpg"),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Start Your Path To Wellness Today",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    // SizedBox(width: 1,),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: const Text(
                        "Full Name",
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
                  controller: nameController,
                  decoration: InputDecoration(
                    label: Text("Enter your name"),
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

                userTypeField(userType: "Consultant"),
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
                    label: Text("name@example.com"),
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
                    "CREATE ACCOUNT",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Spacer(),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
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
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 500),
                            reverseTransitionDuration: const Duration( milliseconds: 500),
                            pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return SharedAxisTransition(animation: animation, secondaryAnimation: secondaryAnimation, transitionType: SharedAxisTransitionType.horizontal, child: child,);
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Login",
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
        ),
      ),
    );
  }
}