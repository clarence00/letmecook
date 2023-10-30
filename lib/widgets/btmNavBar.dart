import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class btmNavBar extends StatefulWidget {
  const btmNavBar({super.key});

  @override
  State<btmNavBar> createState() => _btmNavBarState();
}

class _btmNavBarState extends State<btmNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          padding: EdgeInsets.all(15),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
              gap: 8,
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
              gap: 8,
            ),
            GButton(
              icon: Icons.add,
              text: 'Post',
              gap: 8,
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
              gap: 8,
            ),
          ],
        ),
      ),
    );
  }
}
