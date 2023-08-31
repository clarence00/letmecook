import 'package:flutter/material.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/pages/login_page.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    this.text = 'Button',
    this.buttonStyle = 'primary',
    this.icon = const SizedBox(),
    this.onPressed, // Add this line
    Key? key,
  }) : super(key: key);

  final String text;
  final String buttonStyle;
  final Widget icon;
  final VoidCallback? onPressed; // Define the callback

  @override
  Widget build(context) {
    if (buttonStyle == 'text') {
      return _buildTextButton();
    } else if (buttonStyle == 'circle') {
      return _buildCircleButton();
    } else {
      return _buildElevatedButton();
    }
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
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
      child: StyledText(text, 'button-text'),
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
      child: StyledText(text, 'h3-accent'),
    );
  }

  Widget _buildCircleButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.textbox, // Use the specified color
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(0), // Remove padding
            minimumSize: const Size(70, 70), // Set the size
          ),
          child: const SizedBox(
            width: 50,
            height: 50,
          ),
        ),
        icon
      ],
    );
  }
}
