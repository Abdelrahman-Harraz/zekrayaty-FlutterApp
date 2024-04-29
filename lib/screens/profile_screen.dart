import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text('Full Name: ${userProfile.fullName ?? 'N/A'}'),
            // Text('Email: ${userProfile.email ?? 'N/A'}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
