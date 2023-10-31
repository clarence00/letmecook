import 'package:flutter/material.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/styled_text.dart';

class myAppBar extends StatelessWidget implements PreferredSizeWidget {
  const myAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[900],

      // LET ME COOK TEXT //
      title: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Logos.letMeCookLogoSmall,
          SizedBox(
            width: 15,
          ),
          StyledText(
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
