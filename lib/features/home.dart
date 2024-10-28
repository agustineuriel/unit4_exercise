import 'package:flutter/material.dart';
import 'package:unit4_exercise/utils/styles.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME PAGE!'),
      ),
      body: Center(
        child: Text(
          'Temporary Home Page',
          style: textBold
        ),
      ),
    );
  }
}