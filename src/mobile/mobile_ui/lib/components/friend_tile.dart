import 'package:flutter/material.dart';
import 'package:mobile_ui/models/friend.dart';

// ignore: must_be_immutable
class FriendTile extends StatelessWidget {
  Friend friend;

  FriendTile({
    super.key,
    required this.friend,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text(friend.name),
      subtitle: Text(friend.email),
    );
  }
}