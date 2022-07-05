import 'package:flutter/material.dart';

class ProfileScreenEdit extends StatelessWidget {
  const ProfileScreenEdit({Key? key}) : super(key: key);

  static Route get route => MaterialPageRoute(
        builder: (context) => const ProfileScreenEdit(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
