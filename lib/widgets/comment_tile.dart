import 'package:flutter/material.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/styled_text.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({super.key});

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
                child: CustomIcons.profile(
                  color: AppColors.dark,
                  size: 30,
                ),
              ),
              const Expanded(
                child: Row(
                  children: [
                    StyledText(
                      text: 'Username',
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
                    SizedBox(height: 0),
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
          Container(
            margin: const EdgeInsets.only(left: 30, right: 25),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const StyledText(
                overflow: TextOverflow.clip,
                text: 'Comment blah blah blah blah blah'),
          ),
        ],
      ),
    );
  }
}
