import 'package:flutter/material.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/styled_text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.dark,

      // LET ME COOK TEXT //
      title: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Logos.letMeCookLogoSmall,
          const SizedBox(
            width: 15,
          ),
          const StyledText(
            text: 'LET ME COOK',
            color: AppColors.light,
            size: 32,
            weight: FontWeight.w700,
          )
        ],
      )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
