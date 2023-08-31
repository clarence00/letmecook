import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letmecook/assets/themes/app_colors.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text, this.textStyle, {super.key});

  final String text;
  final String textStyle;

  @override
  Widget build(context) {
    switch (textStyle) {
      case 'h1':
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 42,
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
          ),
          textAlign: TextAlign.left,
        );
      case 'h2':
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
          ),
          textAlign: TextAlign.left,
        );
      case 'h3':
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.dark,
          ),
          textAlign: TextAlign.left,
        );
      case 'h3-accent':
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.accent,
          ),
          textAlign: TextAlign.left,
        );
      case 'h4':
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.dark,
          ),
          textAlign: TextAlign.left,
        );
      case 'h4-bold':
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
          ),
          textAlign: TextAlign.left,
        );

      case 'p':
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.dark,
          ),
        );
      case 'p-accent':
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.accent,
          ),
          textAlign: TextAlign.left,
        );
      case 'button-text':
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
          ),
          textAlign: TextAlign.left,
        );
      default:
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.dark,
          ),
        );
    }
  }
}
