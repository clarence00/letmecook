import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_button.dart';
import 'package:letmecook/widgets/styled_textbox.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/pages/login_page.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: const BoxDecoration(color: AppColors.dark),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Logos.letMeCookLogoSmall,
          const SizedBox(
            width: 8,
          ),
          const StyledText(
            text: 'LET ME COOK',
            color: AppColors.light,
            size: 32,
            weight: FontWeight.w700,
          )
        ],
      ),
    );
  }
}
