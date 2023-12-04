import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/pages/settings_page.dart';
import 'package:letmecook/pages/bookmarks_page.dart';
import 'package:letmecook/widgets/preview_tile.dart';
import 'package:letmecook/widgets/styled_container.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final Future<DocumentSnapshot> userData;
  final currentUser = FirebaseAuth.instance.currentUser;
  bool usernameError = false;
  String username = '';
  String profilePictureUrl = '';
  String imageUrl = '';

  void toSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }

  void toBookmarks() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BookmarksPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    userData = fetchUserData();
  }

  Future<DocumentSnapshot> fetchUserData() async {
    return FirebaseFirestore.instance
        .collection('Usernames')
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Div
            StyledContainer(
              child: FutureBuilder(
                future: userData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Row(
                      children: [
                        CircularProgressIndicator(),
                        Expanded(
                          child: SizedBox(
                            height: 45,
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error loading data');
                  } else {
                    var username =
                        snapshot.data?['Username'] ?? currentUser!.email;
                    var profilePictureUrl =
                        snapshot.data?['ProfilePicture'] ?? currentUser!.email;
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(profilePictureUrl),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: StyledText(
                              text: username,
                              size: 20,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: toSettings,
                          iconSize: 30,
                          color: AppColors.dark,
                          icon: const Icon(
                            Icons.settings,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            // Bookmark Div
            GestureDetector(
              onTap: toBookmarks,
              child: StyledContainer(
                child: Row(
                  children: [
                    const Icon(
                      Icons.bookmark_rounded,
                      size: 40,
                      color: AppColors.dark,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const StyledText(
                        text: 'Bookmarks',
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Sign Out Div
            GestureDetector(
              onTap: () {
                Auth().signOut();
              },
              child: StyledContainer(
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout_sharp,
                      size: 40,
                      color: AppColors.dark,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const StyledText(
                        text: 'Log Out',
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Post Div
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: const EdgeInsets.only(bottom: 15),
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
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 15),
                    alignment: Alignment.centerLeft,
                    child: const StyledText(
                      text: 'Posts',
                      size: 24,
                      weight: FontWeight.w700,
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("User Posts")
                        .where('UserEmail', isEqualTo: currentUser!.email)
                        .orderBy(
                          "TimeStamp",
                          descending: false,
                        )
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            final post = snapshot.data!.docs[index];
                            return PreviewTile(
                              title: post['Title'],
                              imageUrl: '',
                              likes: List<String>.from(post['Likes'] ?? []),
                              bookmarkCount: post['BookmarkCount'],
                              postId: post.id,
                            );
                          }),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: StyledText(text: 'Error:${snapshot.error}'),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
