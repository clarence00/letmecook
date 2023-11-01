import 'package:flutter/material.dart';
import 'package:letmecook/assets/themes/app_colors.dart';

class StyledTextbox extends StatelessWidget {
  const StyledTextbox(
      {Key? key,
      this.obscureText = false,
      this.text = '',
      this.hintText = '',
      this.height = 40,
      required this.controller})
      : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final String text;
  final String hintText;
  final double height;

  @override
  Widget build(BuildContext context) {
    controller.text = text;

    return Container(
      height: height,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: ShapeDecoration(
        color: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 16),
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
