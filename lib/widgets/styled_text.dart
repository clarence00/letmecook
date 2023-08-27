import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            color: const Color.fromRGBO(50, 61, 61, 1),
            height: 63 / 42,
          ),
          textAlign: TextAlign.left,
        );
      case 'button':
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(250, 163, 7, 1),
            height: 27 / 18,
          ),
          textAlign: TextAlign.left,
        );
      case 'button-text':
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(50, 61, 61, 1),
            height: 36 / 22,
          ),
          textAlign: TextAlign.left,
        );
      case 'p':
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(50, 61, 61, 1),
            height: 27 / 18,
          ),
        );
      // Add more cases if needed
      default:
        return Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(50, 61, 61, 1),
            height: 27 / 18,
          ),
        );
    }
  }
}
