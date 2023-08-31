import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_button.dart';
import 'package:letmecook/widgets/styled_textbox.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/pages/login_page.dart';

class LogInWidget extends StatelessWidget {
  final void Function() toggleView; // Use the correct function type

  LogInWidget({required this.toggleView, Key? key}) : super(key: key);
  void buttonPress() {}
  void logIn() {}

  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 10),
          Container(
            width: 325,
            child: const StyledText('LOG IN', 'h1'),
          ),
          Column(
            children: [
              Container(
                width: 325,
                child: const StyledText('Username', 'h3'),
              ),
              Container(
                width: 325,
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: ShapeDecoration(
                  color: AppColors.textbox,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const StyledTextbox('username'),
              ),
              Container(
                width: 325,
                child: const StyledText('Password', 'h3'),
              ),
              Container(
                width: 325,
                height: 40,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: ShapeDecoration(
                  color: AppColors.textbox,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const StyledTextbox('password'),
              ),
              Container(
                width: 325,
                alignment: Alignment.centerRight,
                child: StyledButton(
                    text: 'Forgot Password?',
                    buttonStyle: 'text',
                    onPressed: buttonPress),
              ),
              const SizedBox(height: 10),
            ],
          ),
          Container(
            width: 325,
            alignment: Alignment.center,
            child: StyledButton(
                text: 'Log In', buttonStyle: 'primary', onPressed: logIn),
          ),
          Container(
            width: 325,
            height: 3,
            color: AppColors.dark, // Customize color
            margin:
                const EdgeInsets.symmetric(vertical: 10), // Customize margin
          ),
          Container(
            width: 325,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StyledButton(
                    icon: Logos.googleLogo,
                    buttonStyle: 'circle',
                    onPressed: buttonPress),
                StyledButton(
                    icon: Logos.facebookLogo,
                    buttonStyle: 'circle',
                    onPressed: buttonPress),
                StyledButton(
                    icon: Logos.twitterLogo,
                    buttonStyle: 'circle',
                    onPressed: buttonPress),
              ],
            ),
          ),
          Container(
            width: 325,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const StyledText('Don\'t have an account yet? ', 'h3'),
                StyledButton(
                    text: "Sign up",
                    buttonStyle: 'text',
                    onPressed: toggleView),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
