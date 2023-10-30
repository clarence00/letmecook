import 'package:flutter/material.dart';
import 'package:letmecook/widgets/topAppBar.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAppBar = myAppBar();


    return Scaffold(

      body: Text('Profile'),
    );
  }
}
