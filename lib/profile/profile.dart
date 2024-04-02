import 'package:flutter/material.dart';
import 'package:sama/profile/ProfileSighnIn.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileSighnIn(),
      ],
    );
  }
}
