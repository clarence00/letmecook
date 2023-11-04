import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letmecook/assets/themes/app_colors.dart';

class StyledTextbox extends StatelessWidget {
  const StyledTextbox(
      {Key? key,
      this.obscureText = false,
      this.text = '',
      this.hintText = '',
      this.height = 40,
      this.minLines = 1,
      this.maxLines = 1,
      required this.controller})
      : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final String text;
  final String hintText;
  final double height;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    controller.text = text;

    return Container(
      height: height,
      // margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: ShapeDecoration(
        color: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: TextField(
        minLines: minLines,
        maxLines: maxLines,
        controller: controller,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.dark,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 6),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
