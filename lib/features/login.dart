import 'package:flutter/material.dart';
import 'package:unit4_exercise/features/home.dart';
import 'package:unit4_exercise/utils/reusable.dart';
import 'package:unit4_exercise/utils/styles.dart';
import 'package:unit4_exercise/features/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  String _errorText = '';

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
            child: Form(
              key: _formKey,
            
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
              Container(
                                  width: double.infinity,
                                  child: Text(
                                    _errorText,
                                    style: errorText,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
              Align(alignment: Alignment.centerLeft,
              child: Text('Username', style: subheader),
              ),
              const SizedBox(height: 10),
              reusableTextField('Enter Username', Icons.person, false, _emailTextController),
              const SizedBox(height: 20),

              Align(alignment: Alignment.centerLeft,
              child: Text('Password', style: subheader),
              ),
              const SizedBox(height: 10),
              reusableTextField('Enter Password', Icons.lock_outline_rounded, true, _passwordTextController),

              const SizedBox(height: 20),

              login(context, 'Log in', _login),
               

              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signup()),
                    );
                  },
                  child: Text("Don't have an account? Sign up"),
              ),

            ],
          
          ),
        ),
        ),
      ),
    ));
  }

void _login(BuildContext context) {
    if (_emailTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty) {
      setState(() {
        _errorText = 'Please enter both username and password.';
      });
    } else {
      String enteredUsername = _emailTextController.text.trim();
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
}