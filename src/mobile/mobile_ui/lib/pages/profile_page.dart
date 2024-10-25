import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/my_drawer.dart';
import 'package:mobile_ui/pages/friends_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, 
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Profile Page',
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FriendsPage(),
                  ),
                );
              },
              child: Text(
                'Friends Page',
                style: GoogleFonts.dmSerifText(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}