import 'package:flutter/material.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/styled_text.dart';

class MyAppBarPushed extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBarPushed({
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.dark,
      elevation: 10,
      title: Stack(
        children: [
          Positioned(
            top: 10,
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                width: 40,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.dark,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Logos.letMeCookLogoSmall),
              const StyledText(
                text: 'LET ME COOK',
                color: AppColors.light,
                size: 32,
                weight: FontWeight.w700,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
