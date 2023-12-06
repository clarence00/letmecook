import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/post_tile.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/top_appbar_back.dart';

class SearchedProfilePage extends StatefulWidget {
  const SearchedProfilePage({Key? key, required this.searchedUser})
      : super(key: key);

  final String searchedUser;

  @override
  State<SearchedProfilePage> createState() => _SearchProfilePageState();
}

class _SearchProfilePageState extends State<SearchedProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  String username = '';
  String profilePictureUrl = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void backToPrev() {
    Navigator.of(context).pop();
  }

  void fetchUserData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Usernames')
        .doc(widget.searchedUser)
        .get();
    setState(() {
      username = snapshot.data()?['Username'] ?? widget.searchedUser;
      profilePictureUrl =
          snapshot.data()?['ProfilePicture'] ?? widget.searchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarPushed(onPressed: backToPrev),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: profilePictureUrl != ''
                      ? CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(profilePictureUrl),
                        )
                      : const CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.light,
                          child: CircularProgressIndicator(),
                        ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: StyledText(
                          text: username,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.more_vert,
                  color: AppColors.dark,
                  size: 24,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Usernames")
                  .doc(currentUser!.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final bookmarks = List<String>.from(
                    snapshot.data!['Bookmarks'] ?? [],
                  );

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("User Posts")
                        .where('UserEmail', isEqualTo: widget.searchedUser)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<DocumentSnapshot> filteredPosts = snapshot
                            .data!.docs
                            .where((post) => bookmarks.contains(post.id))
                            .toList();

                        return ListView.builder(
                          itemCount: filteredPosts.length,
                          itemBuilder: (context, index) {
                            final post = filteredPosts[index];
                            return PostTile(
                              title: post['Title'],
                              user: post['UserEmail'],
                              timestamp: post['TimeStamp'],
                              imageUrl: 'imageUrl',
                              likes: List<String>.from(post['Likes'] ?? []),
                              bookmarks:
                                  List<String>.from(post['Bookmarks'] ?? []),
                              postId: post.id,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: StyledText(text: 'Error: ${snapshot.error}'),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: StyledText(text: 'Error: ${snapshot.error}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
