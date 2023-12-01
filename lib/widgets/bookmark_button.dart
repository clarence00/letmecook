import 'package:flutter/material.dart';
import 'package:letmecook/assets/themes/app_colors.dart';

class bookmarkButton extends StatefulWidget {
  bookmarkButton({Key? key, required this.isBookmarked, required this.onTap})
      : super(key: key);

  final bool isBookmarked;
  void Function()? onTap;

  @override
  State<bookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<bookmarkButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Icon(Icons.bookmark,
          color: widget.isBookmarked ? AppColors.accent : AppColors.dark),
    );
  }
}
