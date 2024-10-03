import 'package:flutter/material.dart';
import 'package:mobile_ui/pages/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mobile UI',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}