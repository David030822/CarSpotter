import 'package:flutter/material.dart';
import 'package:mobile_ui/components/drawer_tile.dart';
import 'package:mobile_ui/models/user.dart';
import 'package:mobile_ui/pages/about_page.dart';
import 'package:mobile_ui/pages/event_page.dart';
import 'package:mobile_ui/pages/home_page.dart';
import 'package:mobile_ui/pages/login_page.dart';
import 'package:mobile_ui/pages/profile_page.dart';
import 'package:mobile_ui/pages/settings_page.dart';
import 'package:mobile_ui/pages/statistics_page.dart';
import 'package:mobile_ui/services/api_service.dart';
import 'package:mobile_ui/services/auth_service.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  User? _user;

  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        throw Exception("User is not logged in");
      }
      final userId = await AuthService.getUserIdFromToken(token);
      if (userId == null) {
        throw Exception("Invalid user ID");
      }
      final user = await ApiService.getUserData(userId);

      // Update state with the fetched user
      setState(() {
        _user = user;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // header
                const DrawerHeader(
                  child: Icon(Icons.directions_car),
                ),

                // home tile
                DrawerTile(
                    title: 'H O M E',
                    leading: const Icon(Icons.home),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }),

                // profile tile
                DrawerTile(
                  title: 'P R O F I L E',
                  leading: const Icon(Icons.person),
                  onTap: () {
                    // Itt most statikus adatokat jelenítünk meg, nem kérjük le az adatokat
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(), // Ne adjunk át user adatot
                      ),
                    );
                  },
                ),

                // stats tile
                DrawerTile(
                  title: 'S T A T I S T I S T I C S',
                  leading: const Icon(Icons.show_chart),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StatisticsPage(),
                      ),
                    );
                  },
                ),

                // events tile - heatmap for sold and bought cars
                DrawerTile(
                  title: 'E V E N T S',
                  leading: const Icon(Icons.calendar_month),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EventsPage(),
                      ),
                    );
                  },
                  
                ),

                // settings tile
                DrawerTile(
                  title: 'S E T T I N G S',
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),

                // about tile
                DrawerTile(
                    title: 'A B O U T',
                    leading: const Icon(Icons.info),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutPage()),
                      );
                    }),
              ],
            ),

            // logout tile
            DrawerTile(
              title: 'L O G O U T',
              leading: const Icon(Icons.logout),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
