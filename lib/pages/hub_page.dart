import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/pages/home_page.dart';
import 'package:letmecook/pages/post_page.dart';
import 'package:letmecook/pages/profile_page.dart';
import 'package:letmecook/pages/search_page.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/text_field.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/widgets/wall_post.dart';
import 'package:letmecook/widgets/top_appbar.dart';

class HubPage extends StatefulWidget {
  const HubPage({super.key});

  @override
  State<HubPage> createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    SearchPage(),
    PostPage(),
    ProfilePage(),
  ];

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            onTabChange: (_selectedIndex) {
              navigateBottomBar(_selectedIndex);
              print(_selectedIndex);
            },
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
      ),
      appBar: MyAppBar(),
      body: _children[_selectedIndex],
    );
  }
}
