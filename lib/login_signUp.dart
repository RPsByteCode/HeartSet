import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Image.asset("appIcon.jpg"),
              ),
            ),
            const SizedBox(height: 10,),
            const Text("Welcome Back" , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            const Text("Your Mental Health Journey Continues" , style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
            const SizedBox(height: 30,),
        
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text("ENTER EMAIL ADDRESS"),
                prefixIcon: Icon(Icons.email_outlined),
                
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
        
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
        
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.blue
                  )
                ),
              ),
            ),
        
            const SizedBox(height: 50,),
        
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text("ENTER PASSWORD"),
                prefixIcon: Icon(Icons.lock_outline_sharp),
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
      
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
        
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
        
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Colors.green
                  )
                ),
        
              ),
            ),
      
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Forgot Password?" , style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),textAlign: TextAlign.end,),
              ],
            ),
            const SizedBox(height: 30,),
            
            Container(
              width: 400,
              height: 50,
              
              child: ElevatedButton(onPressed: (){
              }, child: Text("Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent))),
            )
      
          ],
        ),
      ),
    );
  }
}