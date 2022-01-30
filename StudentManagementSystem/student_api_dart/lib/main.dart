import 'package:student_api_dart/screens/login.dart';
import 'package:student_api_dart/screens/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Register(),
        '/login': (context) => Login(),
      },
    );
  }
}
