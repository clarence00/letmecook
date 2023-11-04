import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letmecook/assets/themes/app_colors.dart';

class StyledText extends StatelessWidget {
  const StyledText({
    this.text = 'Text',
    this.size = 16,
    this.weight = FontWeight.w400,
    this.color = AppColors.dark, // Add this line
    Key? key,
  }) : super(key: key);

  final String text;
  final double size;
  final FontWeight weight;
  final Color color;

  @override
  Widget build(context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
      textAlign: TextAlign.left,
    );
  }
}
