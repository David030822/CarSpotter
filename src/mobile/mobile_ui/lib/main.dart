// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_ui/pages/dealer_cars_page.dart';
import 'package:mobile_ui/pages/favourites_page.dart';
import 'package:mobile_ui/pages/home_page.dart';
import 'package:mobile_ui/pages/login_page.dart';
import 'package:mobile_ui/pages/main_page.dart';
import 'package:mobile_ui/pages/search_page.dart';
import 'package:mobile_ui/responsive/desktop_scaffold.dart';
import 'package:mobile_ui/responsive/mobile_scaffold.dart';
import 'package:mobile_ui/responsive/responsive_layout.dart';
import 'package:mobile_ui/responsive/tablet_scaffold.dart';
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
      home: ResponsiveLayout(
        mobileScaffold: /*const MobileScaffold(),*/ const LoginPage(),
        tabletScaffold: const TabletScaffold(),
        desktopScaffold: const DesktopScaffold(),
      ),
      routes: {
        '/home_page': (contsxt) => const HomePage(),
        '/main_page': (context) => const MainPage(),
        '/search_page': (context) => const SearchPage(),
        '/favourites_page': (context) => const FavouritesPage(),
      },
    );
  }
}