import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PostTile extends StatefulWidget {
  PostTile({
    Key? key,
    required this.post,
    required this.user,
    required this.timestamp,
    required this.imageUrl,
  }) : super(key: key);

  // Variables
  final String post;
  final String user;
  final Timestamp timestamp;
  final String imageUrl;

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
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

  String getPostTimeDisplay(Timestamp timestamp) {
    DateTime postTime = timestamp.toDate();
    DateTime now = DateTime.now();
    Duration difference = now.difference(postTime);

    if (difference.inMinutes < 60) {
      return 'Less than an hour ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 4) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d').format(postTime);
    }
  }

  final Color _heartColor = AppColors.dark;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              text: widget.post,
              size: 20,
              weight: FontWeight.w700,
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
                  IconButton(
                    onPressed: () {},
                    icon: CustomIcons.heart(color: _heartColor),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 12),
                    child: const StyledText(
                      text: '12',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: CustomIcons.comment(color: _heartColor),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 12),
                    child: const StyledText(
                      text: '12',
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
    );
  }
}
