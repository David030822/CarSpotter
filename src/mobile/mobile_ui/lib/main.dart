// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_ui/pages/login_page.dart';
import 'package:mobile_ui/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  // FlutterNativeSplash.removeAfter(initialization);
  runApp(
    MultiProvider(
      providers: [
        
        // Theme Provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile UI',
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}