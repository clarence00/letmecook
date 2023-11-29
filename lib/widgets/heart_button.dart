import 'package:flutter/material.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/pages/viewpost_page.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LikeButton extends StatefulWidget {
  LikeButton({Key? key, required this.isLiked, required this.onTap})
      : super(key: key);

  final bool isLiked;
  void Function()? onTap;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Icon(Icons.favorite,
          color: widget.isLiked ? Colors.red : AppColors.dark),
    );
  }
}
