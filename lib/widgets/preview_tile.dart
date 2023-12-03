import 'package:flutter/material.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/styled_text.dart';

class PreviewTile extends StatefulWidget {
  PreviewTile(
      {Key? key,
      required this.title,
      required this.postId,
      required this.likes,
      required this.bookmarkCount})
      : super(key: key);

  // Variables
  final String title;
  final String postId;
  final List<String> likes;
  final int bookmarkCount;
  @override
  State<PreviewTile> createState() => _PreviewTileState();
}

class _PreviewTileState extends State<PreviewTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.dark,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // First Column (Title and status)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15),
                child: const StyledText(
                  text: 'Title',
                  size: 20,
                  weight: FontWeight.w700,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_rounded,
                            size: 18,
                            color: AppColors.dark,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const StyledText(
                          text: "12",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mode_comment_rounded,
                          size: 18,
                          color: AppColors.dark,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const StyledText(
                          text: "12",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.bookmark_rounded,
                          size: 18,
                          color: AppColors.dark,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const StyledText(
                          text: "12",
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          // Container(
          //   margin: const EdgeInsets.only(right: 15),
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       color: AppColors.dark,
          //       width: 2,
          //     ),
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(16),
          //     child: Image.network(
          //       'https://picsum.photos/id/1074/400/400',
          //       fit: BoxFit.cover,
          //       width: 80,
          //       height: 80,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
