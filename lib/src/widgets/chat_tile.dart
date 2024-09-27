import 'package:flutter/material.dart';
import 'package:guffgaff/src/models/user_profile.dart';

class ChatTile extends StatelessWidget {
  final UserProfile userProfile;
  final Function onTap;

  const ChatTile({super.key, required this.userProfile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      dense: false,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          userProfile.profPicURL!,
        ),
      ),
      title: Text(userProfile.fullName!),
    );
  }
}
