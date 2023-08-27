import 'package:flutter/material.dart';
import 'package:letmecook/widgets/styled_text.dart';

class StyledButton extends StatelessWidget {
  const StyledButton(this.text, this.buttonStyle, {super.key});

  final String text;
  final String buttonStyle;

  void buttonPress() {}

  @override
  Widget build(context) {
    switch (buttonStyle) {
      case 'primary':
        return ElevatedButton(
          onPressed: buttonPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(250, 163, 7, 1),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const StyledText('Button', 'button-text'),
        );

      // Add more cases if needed
      default:
        return ElevatedButton(
          onPressed: buttonPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(250, 163, 7, 1),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const StyledText('Button', 'button-text'),
        );
    }
  }
}
