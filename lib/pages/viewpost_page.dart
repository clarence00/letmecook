import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/styled_container.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_textbox.dart';
import 'package:letmecook/widgets/top_appbar.dart';

import '../widgets/comment_tile.dart';

class ViewPostPage extends StatefulWidget {
  const ViewPostPage({super.key});

  @override
  State<ViewPostPage> createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {
  // Variable for UI only (should be changed accordingly)
  final _controllerCommentInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
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
                            child: CustomIcons.profile(
                              color: AppColors.dark,
                              size: 40,
                            ),
                          ),
                          const Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: StyledText(
                                    text: 'Username',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: Icon(
                                    Icons.circle_rounded,
                                    color: AppColors.accent,
                                    size: 8,
                                  ),
                                ),
                                StyledText(
                                  text: 'time',
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
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 5, right: 5),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.dark,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const StyledText(
                                  text: 'Wild',
                                  color: AppColors.light,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5, right: 5),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.dark,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const StyledText(
                                  text: 'Raw Meat',
                                  color: AppColors.light,
                                ),
                              ),
                            ],
                          ),
                          // Title Div
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: const StyledText(
                              text: 'Title',
                              size: 20,
                              weight: FontWeight.w700,
                            ),
                          ),
                          // Description Div
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: const StyledText(
                              text: 'Description blah blah blah',
                              size: 16,
                              weight: FontWeight.w400,
                            ),
                          ),
                          // Image Div
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
                          // React Div
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: CustomIcons.heart(
                                        color: AppColors.dark),
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
                                    icon: CustomIcons.comment(
                                        color: AppColors.dark),
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
                                    icon: CustomIcons.bookmark(
                                        color: AppColors.dark),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.dark,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Column(
                              children: [
                                // Comments
                                CommentTile(),
                                CommentTile(),
                                CommentTile(),
                                CommentTile(),
                                CommentTile(),
                              ],
                            ),
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      controller: _controllerCommentInput,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none,
                        hintText: 'Add Comments',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
