import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/pages/home_page.dart';
import 'package:letmecook/pages/post_page.dart';
import 'package:letmecook/pages/profile_page.dart';
import 'package:letmecook/pages/search_page.dart';
import 'package:letmecook/widgets/top_appbar.dart';

class HubPage extends StatefulWidget {
  const HubPage({super.key});

  @override
  State<HubPage> createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    const HomePage(),
    const SearchPage(),
    const PostPage(),
    const ProfilePage(),
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
        color: AppColors.background,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          decoration: const BoxDecoration(
            color: AppColors.dark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: GNav(
            color: AppColors.light,
            activeColor: AppColors.dark,
            tabBackgroundColor: AppColors.light,
            tabBorderRadius: 20,
            gap: 8,
            padding: const EdgeInsets.all(10),
            onTabChange: (selectedItem) {
              navigateBottomBar(selectedItem);
            },
            tabs: const [
              GButton(
                icon: Icons.home_filled,
                iconSize: 24,
                text: "HOME",
                textStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              GButton(
                icon: Icons.search_outlined,
                iconSize: 24,
                text: "SEARCH",
                textStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              GButton(
                icon: Icons.add,
                iconSize: 24,
                text: "POST",
                textStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              GButton(
                icon: Icons.account_circle_rounded,
                iconSize: 24,
                text: "PROFILE",
                textStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
      appBar: const MyAppBar(),
      body: _children[_selectedIndex],
    );
  }
}
