import 'package:flutter/material.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class CommentTile extends StatefulWidget {
  const CommentTile(
      {super.key, required this.user, required this.text, required this.time});

  final String user;
  final String text;
  final Timestamp time;

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  String username = '';
  String profilePictureUrl = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Usernames')
        .doc(widget.user)
        .get();
    setState(() {
      username = snapshot.data()?['Username'] ?? widget.user;
      profilePictureUrl = snapshot.data()?['ProfilePicture'] ?? widget.user;
    });
  }

  String getCommentTimeDisplay(Timestamp timestamp) {
    DateTime commentTime = timestamp.toDate();
    DateTime now = DateTime.now();
    Duration difference = now.difference(commentTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else if (difference.inDays < 365) {
      return DateFormat('MMM d').format(commentTime);
    } else {
      return DateFormat('MMMM d, y').format(commentTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: profilePictureUrl != ''
                    ? CircleAvatar(
                        radius: 14,
                        backgroundImage: NetworkImage(profilePictureUrl),
                      )
                    : const CircularProgressIndicator(),
              ),
              Expanded(
                child: Row(
                  children: [
                    StyledText(
                      text: username,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Icon(
                        Icons.circle_rounded,
                        color: AppColors.accent,
                        size: 8,
                      ),
                    ),
                    // Time
                    StyledText(
                      text: getCommentTimeDisplay(widget.time),
                      size: 12,
                      color: AppColors.accent,
                    ),
                    const SizedBox(height: 0),
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
          // Comment
          Container(
            margin: const EdgeInsets.only(left: 30, right: 25),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: StyledText(overflow: TextOverflow.clip, text: widget.text),
          ),
        ],
      ),
    );
  }
}
