import 'package:flutter/material.dart';
import 'package:unit4_exercise/utils/reusable.dart';
import 'package:unit4_exercise/utils/styles.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Remove the extra comma
            children: [
              Image.asset('logo.png', height: 200),
              const SizedBox(height: 20),
              Text(
                "TranspoTrack",
                style: header,
              ),

              const SizedBox(height: 20),
              Align(alignment: Alignment.centerLeft,
              child: Text('Username', style: subheader),
              ),
              const SizedBox(height: 10),
              reusableTextField('Enter Username', Icons.person, false),
              const SizedBox(height: 20),

              Align(alignment: Alignment.centerLeft,
              child: Text('Password', style: subheader),
              ),
              const SizedBox(height: 10),
              reusableTextField('Enter Password', Icons.lock_outline_rounded, true),

              const SizedBox(height: 20),
              Container(width: MediaQuery.of(context).size.width, 
              height: 50, margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
              
              child: ElevatedButton(
                  onPressed: () {
                  },
                  child: Text("Login", style: subheader),
              ),
              ),
            
            ],
          ),
        ),
        ),
      ),
    );
  }
}