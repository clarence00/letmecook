import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/pages/viewpost_page.dart';
import 'package:letmecook/widgets/bookmark_button.dart';
import 'package:letmecook/widgets/heart_button.dart';
import 'package:letmecook/widgets/styled_text.dart';

class PostTile extends StatefulWidget {
  PostTile(
      {Key? key,
      required this.title,
      required this.user,
      required this.timestamp,
      required this.imageUrl,
      required this.postId,
      required this.likes,
      required this.bookmarkCount})
      : super(key: key);

  // Variables
  final String title;
  final String user;
  final Timestamp timestamp;
  final String imageUrl;
  final String postId;
  final List<String> likes;
  final int bookmarkCount;

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  late final Future<DocumentSnapshot> userData;
  late Future<String?> imageUrlFuture;
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;
  bool isBookmarked = false;
  String username = '';
  String profilePictureUrl = '';
  String _imageUrl = '';
  Future<int>? commentCount;
  int bookmarkCount = 0;

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
    imageUrlFuture = getImageUrl(widget.imageUrl);
    isLiked = widget.likes.contains(currentUser!.email);
    fetchIsBookmarked();
    commentCount = fetchCommentCount();
    bookmarkCount = widget.bookmarkCount;
    fetchBookmarkCount();
  }

  Future<void> fetchIsBookmarked() async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Usernames')
        .doc(currentUser!.email)
        .get();

    if (userSnapshot.exists) {
      setState(() {
        isBookmarked = (userSnapshot['Bookmarks'] as List<dynamic>)
            .contains(widget.postId);
      });
    }
  }

  Future<void> fetchBookmarkCount() async {
    DocumentSnapshot postSnapshot = await FirebaseFirestore.instance
        .collection('User Posts')
        .doc(widget.postId)
        .get();

    if (postSnapshot.exists) {
      setState(() {
        bookmarkCount = postSnapshot['BookmarkCount'] ?? 0;
      });
    }
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference userRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      userRef.update({
        'Likes': FieldValue.arrayUnion([currentUser!.email])
      });
    } else {
      userRef.update({
        'Likes': FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });

    DocumentReference userRef = FirebaseFirestore.instance
        .collection('Usernames')
        .doc(currentUser!.email);

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isBookmarked) {
      userRef.update({
        'Bookmarks': FieldValue.arrayUnion([widget.postId]),
      });
      postRef.update({
        'BookmarkCount': FieldValue.increment(1),
      });
    } else {
      userRef.update({
        'Bookmarks': FieldValue.arrayRemove([widget.postId]),
      });
      postRef.update({
        'BookmarkCount': FieldValue.increment(-1),
      });
    }
    fetchBookmarkCount();
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
        .collection('Comments')
        .get();

    int documentCount = querySnapshot.docs.length;
    return documentCount;
  }

  Future<String?> getImageUrl(String imageUrl) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('User Posts')
          .doc(widget.postId) // Replace with the actual document ID
          .get();

      if (documentSnapshot.exists) {
        // If the document exists, retrieve the value of 'ImageUrl' field
        return documentSnapshot['ImageUrl'] as String?;
      } else {
        // If the document doesn't exist
        return null;
      }
    } catch (e) {
      // Handle any potential errors
      print('Error fetching data: $e');
      return null;
    }
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
                child: FutureBuilder<String?>(
                  future: imageUrlFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data == null) {
                      return Text(' ');
                    } else {
                      // Use the retrieved URL
                      _imageUrl = snapshot.data!;
                      return Image.network(_imageUrl);
                    }
                  },
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

                // Bookmark
                Row(
                  children: [
                    bookmarkButton(
                        onTap: toggleBookmark, isBookmarked: isBookmarked),
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 12),
                      child: StyledText(
                        text: bookmarkCount.toString(),
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
