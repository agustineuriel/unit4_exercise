import 'package:flutter/material.dart';
import 'package:unit4_exercise/utils/reusable.dart';
import 'package:unit4_exercise/utils/styles.dart';
import 'package:unit4_exercise/features/home.dart';

  class Signup extends StatefulWidget {
    const Signup({super.key});

  @override
    _SignupState createState() => _SignupState();
  }

  class _SignupState extends State<Signup> {
    final TextEditingController _usernameTextController = TextEditingController();
    final TextEditingController _passwordTextController = TextEditingController();
    String _errorText= '';

  @override
  void dispose() {
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  void _signup() {
    if (_usernameTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty) {
          setState(() {
            _errorText = 'Please enter both username and password.';

          });


        } else {
          String enteredUsername = _usernameTextController.text.trim();
          String enteredPassword = _passwordTextController.text.trim();

          const username = 'admin';
          const password = 'admin';

            if (enteredUsername == username && enteredPassword == password) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
          } else {
            setState(() {
              _errorText = 'Invalid username or password.';
            });
            }
          }
          }
        
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
              reusableTextField('Enter Username', Icons.person, false, _usernameTextController),
              const SizedBox(height: 20),

              Align(alignment: Alignment.centerLeft,
              child: Text('Password', style: subheader),
              ),
              const SizedBox(height: 10),
              reusableTextField('Enter Password', Icons.lock_outline_rounded, true, _passwordTextController),

              const SizedBox(height: 20),
              Container(width: MediaQuery.of(context).size.width, 
              height: 50, margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
              
              child: ElevatedButton(
                  onPressed: _signup, 
        
                  child: Text("Sign Up", style: subheader),
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