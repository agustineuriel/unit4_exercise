import 'package:flutter/material.dart';
import 'package:unit4_exercise/utils/reusable.dart';
import 'package:unit4_exercise/utils/styles.dart';
import 'package:unit4_exercise/features/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 
final storage = FlutterSecureStorage();

void _saveCredentials(String username, String password) async {
  await storage.write(key: 'username', value: username);
  await storage.write(key: 'password', value: password);
}

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

Widget reusableTextField(
  String hintText,
  IconData icon,
  bool isPasswordType, {
  required TextEditingController controller,
  FormFieldValidator<String>? validator,
}) {
  return TextFormField(
    controller: controller, // Controller is passed to TextFormField
    obscureText: isPasswordType,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(),
    ),
    validator: validator,
  );
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


void _validateAndSignup() {
  if (_formKey.currentState!.validate()) {
    _saveCredentials(_usernameController.text, _passwordController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signup successful!')),
    );

  Navigator.pop(context);
 // Navigator.push(
  //  context,
  //  MaterialPageRoute(builder: (context) => Home()),
 // );
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Padding(
        padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Remove the extra comma
            children: [
              Image.asset('TranspoTrack.png', height: 200),
              const SizedBox(height: 20),
              Text(
                "Sign-up Page",
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
              },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text ('Email', style: subheader),
              ),
              const SizedBox(height: 10),
              reusableTextField(
                'Enter Email',
                Icons.person,
                false,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
                },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Password', style: subheader),
              ),
              const SizedBox(height:10),
              reusableTextField(
                'Enter Password',
                Icons.lock,
                true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                  }
              ),
              const SizedBox(height: 20),
              Align(
              alignment: Alignment.centerLeft,
              child: Text('Confirm Password', style: subheader),
              ),
              const SizedBox(height: 10),
              reusableTextField(
                'Re-Enter Password', 
                Icons.lock,
                true,
                controller: _confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                  }
                ),
              const SizedBox(height: 30),
              Container(
              width: MediaQuery.of(context).size.width, 
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration: 
              BoxDecoration(borderRadius: BorderRadius.circular(90)),
              child: ElevatedButton(
                  onPressed: _validateAndSignup,
                  child: Text("Signup", style: subheader),
              ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Already have an account? Login"),
              ),
              ],
              ),
              ),
              ),
              ));
}
  }