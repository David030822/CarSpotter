// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_ui/pages/favourites_page.dart';
import 'package:mobile_ui/pages/home_page.dart';
import 'package:mobile_ui/pages/login_page.dart';
import 'package:mobile_ui/pages/main_page.dart';
import 'package:mobile_ui/pages/search_page.dart';
import 'package:mobile_ui/responsive/desktop_scaffold.dart';
// ignore: unused_import
import 'package:mobile_ui/responsive/mobile_scaffold.dart';
import 'package:mobile_ui/responsive/responsive_layout.dart';
import 'package:mobile_ui/responsive/tablet_scaffold.dart';
import 'package:mobile_ui/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //initializing the FireBase before the app starts
  // FlutterNativeSplash.removeAfter(initialization);
  try{
       await Firebase.initializeApp(); //initilaize firebase here
  }catch (e) {
    print("Firebase initialization failed: $e");
  }
 
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