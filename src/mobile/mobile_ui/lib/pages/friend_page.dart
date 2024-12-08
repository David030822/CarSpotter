import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_ui/components/custom_button.dart';
import 'package:mobile_ui/models/user.dart';
import 'dart:io';

import 'package:mobile_ui/services/api_service.dart';
import 'package:mobile_ui/services/auth_service.dart';

class FriendPage extends StatefulWidget {
  final User user;
  const FriendPage({super.key, required this.user});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  bool _isFollowing = false;
  bool _isLoading = true;
  File? _image;

  @override
  void initState() {
    super.initState();
    _checkFollowingStatus();
  }

  void _checkFollowingStatus() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        throw Exception("User is not logged in");
      }
      final userId = await AuthService.getUserIdFromToken(token);
      if (userId == null) {
        throw Exception("Invalid user ID");
      }

      // API hívás az aktuális követési státusz lekérdezésére
      _isFollowing = await ApiService.isFollowing(userId, widget.user.id);
      setState(() {
        _isLoading = false;  // Adatok betöltése után frissítjük az UI-t
      });
    } catch (e) {
      setState(() {
        _isLoading = false;  // Ha hiba történt, akkor is frissíteni kell az UI-t
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error checking following status: ${e.toString()}')),
      );
    }
  }

  void _followUser() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        throw Exception("User is not logged in");
      }
      final userId = await AuthService.getUserIdFromToken(token);
      if (userId == null) {
        throw Exception("Invalid user ID");
      }

      await ApiService.addFollowing(userId, widget.user.id);
      setState(() {
        _isFollowing = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User followed successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _unfollowUser() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        throw Exception("User is not logged in");
      }
      final userId = await AuthService.getUserIdFromToken(token);
      if (userId == null) {
        throw Exception("Invalid user ID");
      }

      await ApiService.deleteFollowing(userId, widget.user.id);
      setState(() {
        _isFollowing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User unfollowed successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                'User profile page',
                style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 80,
            backgroundColor: Colors.grey[300],
            child: _image != null
                ? ClipOval(
                    child: Image.file(
                      _image!,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  )
                : (widget.user.profileImage != null
                    ? ClipOval(
                        child: widget.user.getDecodedProfileImage() != null
                            ? Image.memory(
                                widget.user.getDecodedProfileImage()!,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.person, size: 80),
                      )
                    : const Icon(Icons.person, size: 80)),
          ),
          const SizedBox(height: 10),
          // Gomb csak akkor látható, ha az adatokat sikerült betölteni
          if (!_isLoading)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CustomButton(
                    color: Theme.of(context).colorScheme.tertiary,
                    textColor: Theme.of(context).colorScheme.outline,
                    onPressed: _isFollowing ? _unfollowUser : _followUser,
                    label: _isFollowing ? 'Unfollow' : '+ Follow',
                  ),
                ),
              ],
            ),
          const SizedBox(height: 10),
          itemProfile('Name', '${widget.user.firstName} ${widget.user.lastName}', CupertinoIcons.person),
          const SizedBox(height: 10),
          itemProfile('Phone', widget.user.phoneNum, CupertinoIcons.phone),
          const SizedBox(height: 10),
          itemProfile('Email', widget.user.email, CupertinoIcons.mail),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Text(
                '${widget.user.firstName}\'s favourite dealers',
                style: GoogleFonts.dmSerifText(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
          // display this user's fav dealers using dealer tile
        ],
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.grey.withOpacity(.2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(iconData),
        ),
      ),
    );
  }
}


