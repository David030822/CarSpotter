import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/custom_button.dart';
import 'package:mobile_ui/components/friend_tile.dart';
import 'package:mobile_ui/components/my_text_field.dart';
import 'package:mobile_ui/constants.dart';
import 'package:mobile_ui/models/user.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final _searchController = TextEditingController();
  bool _isLoading = false;
  List<User> _usersFound = [];

  void _searchUsers() async {
    setState(() {
      _isLoading = true;
      _usersFound = [];
    });

    try {
      // search logic using api

      setState(() {});

      if (_usersFound.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No users found with the given name.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      // drawer: const MyDrawer(),
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: MyTextField(
                          controller: _searchController,
                          hintText: 'Enter a username',
                          obscureText: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: CustomButton(
                        color: Theme.of(context).colorScheme.tertiary,
                        textColor: Theme.of(context).colorScheme.outline,
                        onPressed: _searchUsers,
                        label: 'Search',
                      ),
                    ),
                  ],
                ),
                if (_isLoading) const CircularProgressIndicator(),
                if (!_isLoading &&
                    _usersFound.isEmpty &&
                    _searchController.text.isNotEmpty)
                  Text(
                    'No users found with name "${_searchController.text}".',
                    style: const TextStyle(color: Colors.grey),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            // display search results here using friend tile
            

            Text(
              'Your friends will appear here',
              style: GoogleFonts.dmSerifText(
                fontSize: 24,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),

            Expanded(
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                // get friend from friend list/db
                User friend = getUserList()[index + 1];

                return FriendTile(friend: friend);
              },
            ),
          ),
          ],
        ),
      ),
    );
  }
}