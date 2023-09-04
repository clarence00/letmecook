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
  void logIn() {
    print('Log in');
  }

  void forgotPassword() {
    print('Forgot password');
  }

  void logInWithGoogle() {
    print('Log in with Google');
  }

  void logInWithFacebook() {
    print('Log in with Facebook');
  }

  void logInWithTwitter() {
    print('Log in with Twitter');
  }

  @override
  Widget build(context) {
    return Animate(
      effects: [
        SlideEffect(
            duration: 1000.ms,
            begin: Offset(0, 1),
            end: Offset(0, 0),
            curve: Curves.fastLinearToSlowEaseIn)
      ],
      child: Container(
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
              child: const StyledText(
                text: 'LOG IN',
                size: 42,
                weight: FontWeight.w700,
              ),
            ),
            Column(
              children: [
                Container(
                  width: 325,
                  child: const StyledText(text: 'Username', size: 18),
                ),
                Container(
                  width: 325,
                  height: 40,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: ShapeDecoration(
                    color: AppColors.background,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const StyledTextbox(type: 'username'),
                ),
                Container(
                  width: 325,
                  child: const StyledText(text: 'Password', size: 18),
                ),
                Container(
                  width: 325,
                  height: 40,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: ShapeDecoration(
                    color: AppColors.background,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const StyledTextbox(type: 'password'),
                ),
                Container(
                  width: 325,
                  alignment: Alignment.centerRight,
                  child: StyledButton(
                      text: 'Forgot Password?',
                      buttonStyle: 'text',
                      onPressed: forgotPassword),
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
                      onPressed: logInWithGoogle),
                  StyledButton(
                      icon: Logos.facebookLogo,
                      buttonStyle: 'circle',
                      onPressed: logInWithFacebook),
                  StyledButton(
                      icon: Logos.twitterLogo,
                      buttonStyle: 'circle',
                      onPressed: logInWithTwitter),
                ],
              ),
            ),
            Container(
              width: 325,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const StyledText(
                      text: 'Don\'t have an account yet? ', size: 18),
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
      ),
    );
  }
}
