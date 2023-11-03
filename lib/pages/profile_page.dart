import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/pages/post_page.dart';
import 'package:letmecook/pages/profile_page.dart';
import 'package:letmecook/pages/search_page.dart';
import 'package:letmecook/pages/settings_page.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_button.dart';
import 'package:letmecook/widgets/styled_textbox.dart';
import 'package:letmecook/widgets/text_field.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/widgets/wall_post.dart';
import 'package:letmecook/widgets/top_appbar.dart';
import 'package:letmecook/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _controllerUsername = TextEditingController();
  bool usernameError = false;
  late String username = '';
  late String profilePictureUrl = '';

  void toSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchUsername();
    fetchProfilePicture();
  }

  void fetchUsername() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Usernames')
        .doc(currentUser!.email)
        .get();
    setState(() {
      username = snapshot.data()?['Username'] ?? currentUser!.email;
    });
  }

  void fetchProfilePicture() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Usernames')
          .doc(currentUser!.email)
          .get();
      setState(() {
        profilePictureUrl =
            snapshot.data()?['ProfilePicture'] ?? currentUser!.email;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.light,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.dark.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(profilePictureUrl),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: StyledText(
                          text: username,
                          size: 18,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: toSettings,
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Auth().signOut();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.light,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.dark.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(Icons.arrow_back),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const StyledText(
                            text: 'Log out',
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
