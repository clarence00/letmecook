import 'package:flutter/material.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/assets/themes/app_colors.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    this.text = 'Button',
    this.buttonStyle = 'primary',
    this.icon = const SizedBox(),
    this.size = 70,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final String text;
  final String buttonStyle;
  final Widget icon;
  final double size;
  final VoidCallback? onPressed; // Define the callback

  @override
  Widget build(context) {
    if (buttonStyle == 'text') {
      return _buildTextButton();
    } else if (buttonStyle == 'circle') {
      return _buildCircleButton();
    } else if (buttonStyle == 'icon') {
      return _buildIconButton();
    } else if (buttonStyle == 'primary') {
      return _buildPrimaryButton();
    } else {
      return _buildElevatedButton();
    }
  }

  Widget _buildElevatedButton() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.dark.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 4,
          minimumSize: const Size(double.infinity, 55),
        ),
        child: StyledText(text: text, size: 26, weight: FontWeight.w700),
      ),
    );
  }

  Widget _buildPrimaryButton() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.dark.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: StyledText(text: text, size: size, weight: FontWeight.w700),
      ),
    );
  }

  Widget _buildTextButton() {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
      ),
      child: StyledText(
          text: text,
          size: 18,
          weight: FontWeight.w700,
          color: AppColors.accent),
    );
  }

  Widget _buildCircleButton() {
    return Container(
      height: size,
      width: size,
      decoration: const ShapeDecoration(
        color: AppColors.background,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildIconButton() {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
    );
  }
}
