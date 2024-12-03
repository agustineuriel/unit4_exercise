import 'package:flutter/material.dart';
import 'package:unit4_exercise/utils/reusable.dart';
import 'package:unit4_exercise/utils/styles.dart';
import 'package:unit4_exercise/features/signup.dart';
import 'package:unit4_exercise/features/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//Here is the login screen

final storage = FlutterSecureStorage();


class Login extends StatefulWidget {
  const Login({super.key});

@override
_LoginState createState() => _LoginState();
}


//Reusable TextField with validation
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

//State managament for login

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


    //validate and handle login
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
    
//This is the login function

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
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              Image.asset('Transpotrack.png', height: 300),
              const SizedBox(height: 20),
              Text(
                "To-do List",
                style: header,
                
              ),
           
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Username', style: subheader), //username field
              ),
              const SizedBox(height: 10),
              reusableTextField(
              'Enter Username', 
              Icons.person, 
              false,
              controller: _usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';//username validation
                }
                return null;
              }
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Password', style: subheader),//password field
              ),
              const SizedBox(height: 10),
              reusableTextField('Enter Password', 
              Icons.lock_outline_rounded, 
              true,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';//password validation
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

              //button to navigate to signup screen
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
