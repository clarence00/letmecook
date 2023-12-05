import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/styled_container.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:letmecook/widgets/heart_button.dart';
import 'package:intl/intl.dart';
import 'package:letmecook/widgets/top_appbar_back.dart';

import '../widgets/comment_tile.dart';

class ViewPostPage extends StatefulWidget {
  const ViewPostPage({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final String postId;

  @override
  State<ViewPostPage> createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {
  final _controllerComment = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  String username = '';
  String profilePictureUrl = '';
  String title = '';
  String message = '';
  String imageUrl = '';
  String userEmail = '';
  List<dynamic> ingredients = [];
  List<dynamic> steps = [];
  List<dynamic> categories = [];
  bool isLiked = false;
  Timestamp timestamp = Timestamp.fromDate(DateTime.now());
  String likes = '0';
  int bookmarkCount = 0;

  @override
  void initState() {
    super.initState();
    _controllerComment.text = '';
    fetchPostData();
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

  void addComment() {
    if (_controllerComment.text.trim().isNotEmpty) {
      FirebaseFirestore.instance
          .collection('User Posts')
          .doc(widget.postId)
          .collection('Comments')
          .add({
        'UserEmail': currentUser!.email,
        'Comment': _controllerComment.text,
        'TimeStamp': Timestamp.now()
      });
      setState(() {
        _controllerComment.clear();
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              ViewPostPage(postId: widget.postId),
        ),
      );
    }
  }

  void fetchPostData() async {
    final postDoc = await FirebaseFirestore.instance
        .collection('User Posts')
        .doc(widget.postId)
        .get();
    setState(() {
      title = postDoc.data()?['Title'];
      userEmail = postDoc.data()?['UserEmail'];
      message = postDoc.data()?['Message'];
      imageUrl = postDoc.data()?['ImageUrl'];
      timestamp = postDoc.data()?['TimeStamp'];
      ingredients = postDoc.data()?['Ingredients'] ?? [];
      steps = postDoc.data()?['Steps'] ?? [];
      categories = postDoc.data()?['Category'] ?? [];
      isLiked = postDoc.data()?['Likes'].contains(currentUser!.email);
      likes = postDoc.data()?['Likes'].length.toString() ?? '0';
      bookmarkCount = postDoc.data()?['BookmarkCount'] ?? 0;
      fetchUserData();
    });
  }

  void fetchUserData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Usernames')
        .doc(userEmail)
        .get();
    setState(() {
      username = snapshot.data()?['Username'] ?? userEmail;
      profilePictureUrl = snapshot.data()?['ProfilePicture'] ?? userEmail;
    });
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

  String formatList(List<dynamic> list) {
    return list
        .asMap()
        .entries
        .map((entry) => '${entry.key + 1}. ${entry.value}')
        .join('\n');
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

  void backToPrev() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarPushed(onPressed: backToPrev),
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: [
                    // User Profile Div
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
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
                          // First Div (Profile)
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: profilePictureUrl != ''
                                ? CircleAvatar(
                                    radius: 16,
                                    backgroundImage:
                                        NetworkImage(profilePictureUrl),
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
                                  text: getPostTimeDisplay(timestamp),
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
                    ),
                    // Post Div
                    StyledContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Category Div
                          Wrap(
                            children: [
                              for (var category in categories)
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, right: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.dark,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: StyledText(
                                    text: category,
                                    color: AppColors.light,
                                  ),
                                ),
                            ],
                          ),
                          // Title Div
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: StyledText(
                              text: title,
                              size: 20,
                              weight: FontWeight.w700,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          // Description Div
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: StyledText(
                              text: message,
                              size: 16,
                              weight: FontWeight.w400,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: const StyledText(
                              text: 'Ingredients: ',
                              size: 20,
                              weight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: StyledText(
                              text: formatList(ingredients),
                              size: 16,
                              weight: FontWeight.w400,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: const StyledText(
                              text: 'Steps: ',
                              size: 20,
                              weight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: StyledText(
                              text: formatList(steps),
                              size: 16,
                              weight: FontWeight.w400,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          // Image Div
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: imageUrl == ''
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          // React Div
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  LikeButton(onTap: () {}, isLiked: isLiked),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 12),
                                    child: StyledText(
                                      text: likes,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CustomIcons.comment(),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 12),
                                    child: FutureBuilder<int>(
                                      future: fetchCommentCount(),
                                      builder: (context, snapshot) {
                                        return StyledText(
                                          text:
                                              snapshot.data?.toString() ?? '0',
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: CustomIcons.bookmark(
                                        color: AppColors.dark),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(right: 12),
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
                    // Comment Div
                    StyledContainer(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.centerLeft,
                            child: const StyledText(
                              text: 'Comments',
                              size: 20,
                              weight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.dark,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('User Posts')
                                    .doc(widget.postId)
                                    .collection('Comments')
                                    .orderBy('TimeStamp', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children:
                                            snapshot.data!.docs.map((doc) {
                                          final commentData = doc.data()
                                              as Map<String, dynamic>;
                                          return CommentTile(
                                            text: commentData['Comment'],
                                            user: commentData['UserEmail'],
                                            time: commentData['TimeStamp'],
                                          );
                                        }).toList());
                                  } else {
                                    return const Expanded(
                                      child: SizedBox(height: 15),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: AppColors.background,
          child: Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
            decoration: const BoxDecoration(
              color: AppColors.dark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      maxLines: null,
                      controller: _controllerComment,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark,
                      ),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 7),
                        border: InputBorder.none,
                        hintText: 'Add Comments',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: addComment,
                  icon: const Icon(Icons.send_rounded),
                  color: AppColors.light,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
