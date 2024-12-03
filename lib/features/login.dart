import 'package:flutter/material.dart';
import 'package:unit4_exercise/utils/reusable.dart';
import 'package:unit4_exercise/utils/styles.dart';
import 'package:unit4_exercise/features/signup.dart';
import 'package:unit4_exercise/features/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();


class Login extends StatefulWidget {
  const Login({super.key});

@override
_LoginState createState() => _LoginState();
}



Widget reusableTextField(
  String hintText,
  IconData icon,
  bool isPassword, {
  TextEditingController? controller,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
    validator: validator,
  );
}


class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

    Future<void> _validateAndLogin() async {
  if (_formKey.currentState!.validate()) {
    String? savedUsername = await storage.read(key: 'username');
    String? savedPassword = await storage.read(key: 'password');

    if (_usernameController.text == savedUsername &&
        _passwordController.text == savedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password.')),
      );
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Username', style: subheader),
              ),
              const SizedBox(height: 10),
              reusableTextField(
              'Enter Username', 
              Icons.person, 
              false,
              controller: _usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              }
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Password', style: subheader),
              ),
              const SizedBox(height: 10),
              reusableTextField('Enter Password', 
              Icons.lock_outline_rounded, 
              true,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              }
              ),

              const SizedBox(height: 20),
              Container(
              width: MediaQuery.of(context).size.width, 
              height: 50, 
              margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration: 
              BoxDecoration(borderRadius: BorderRadius.circular(90)),
              
              child: ElevatedButton(
                  onPressed: _validateAndLogin,
                  child: Text("Login", style: subheader),
              ),
              ),
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
    )
    );
  }
}
