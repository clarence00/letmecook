import 'package:flutter/material.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/pages/viewpost_page.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/heart_button.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class PostTile extends StatefulWidget {
  PostTile({
    Key? key,
    required this.title,
    required this.user,
    required this.timestamp,
    required this.imageUrl,
    required this.postId,
    required this.likes,
  }) : super(key: key);

  // Variables
  final String title;
  final String user;
  final Timestamp timestamp;
  final String imageUrl;
  final String postId;
  final List<String> likes;

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  late final Future<DocumentSnapshot> userData;
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;
  String username = '';
  String profilePictureUrl = '';
  Future<int>? commentCount;

  void toViewPost() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewPostPage(postId: widget.postId)));
  }

  @override
  void initState() {
    super.initState();
    userData = fetchUserData();
    isLiked = widget.likes.contains(currentUser!.email);
    commentCount = fetchCommentCount();
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser!.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }

  Future<DocumentSnapshot> fetchUserData() async {
    return FirebaseFirestore.instance
        .collection('Usernames')
        .doc(widget.user)
        .get();
  }

  Future<int> fetchCommentCount() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('User Posts')
        .doc(widget.postId)
        .collection('Comments') // Replace with your collection name
        .get();

    int documentCount = querySnapshot.docs.length;
    return documentCount;
  }

  String getPostTimeDisplay(Timestamp timestamp) {
    DateTime postTime = timestamp.toDate();
    DateTime now = DateTime.now();
    Duration difference = now.difference(postTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else if (difference.inDays < 365) {
      return DateFormat('MMM d').format(postTime);
    } else {
      return DateFormat('MMMM d, y').format(postTime);
    }
  }

  final Color _heartColor = AppColors.dark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toViewPost();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // First Div (Profile)
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: FutureBuilder(
                      future: userData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColors.light,
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          profilePictureUrl = snapshot.data?['ProfilePicture'];
                          return CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(profilePictureUrl),
                          );
                        }
                      }),
                ),
                Expanded(
                  child: Row(
                    children: [
                      FutureBuilder(
                          future: userData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Flexible(
                                child: StyledText(
                                  text: '',
                                ),
                              );
                            } else {
                              username =
                                  snapshot.data?['Username'] ?? widget.user;
                              return Flexible(
                                child: StyledText(
                                  text: username,
                                ),
                              );
                            }
                          }),
                      const Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Icon(
                          Icons.circle_rounded,
                          color: AppColors.accent,
                          size: 8,
                        ),
                      ),
                      StyledText(
                        text: getPostTimeDisplay(widget.timestamp),
                        size: 12,
                        color: AppColors.accent,
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
            // Second Div (Title)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.centerLeft,
              child: StyledText(
                text: widget.title,
                size: 20,
                weight: FontWeight.w700,
                overflow: TextOverflow.clip,
              ),
            ),
            // Third Div (Image)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://picsum.photos/id/1074/400/400',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Fourth Div (Reacts)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    LikeButton(onTap: toggleLike, isLiked: isLiked),
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 12),
                      child: StyledText(
                        text: widget.likes.length.toString(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomIcons.comment(),
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 12),
                      child: FutureBuilder<int>(
                        future: commentCount,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const StyledText(
                              text: '0',
                            );
                          } else {
                            return StyledText(
                              text: snapshot.data?.toString() ?? '0',
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: CustomIcons.bookmark(color: _heartColor),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 12),
                      child: const StyledText(
                        text: '12',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
