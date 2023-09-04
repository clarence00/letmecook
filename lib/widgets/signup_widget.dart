import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_button.dart';
import 'package:letmecook/widgets/styled_textbox.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/pages/login_page.dart';

class SignUpWidget extends StatelessWidget {
  final void Function() toggleView; // Use the correct function type

  SignUpWidget({required this.toggleView, Key? key}) : super(key: key);
  void signUp() {
    print('Sign up');
  }

  void signUpWithGoogle() {
    print('Sign up with Google');
  }

  void signUpWithFacebook() {
    print('Sign up with Facebook');
  }

  void signUpWithTwitter() {
    print('Sign up with Twitter');
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
                text: 'SIGN UP',
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
                  child: const StyledText(text: 'Email', size: 18),
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
                  child: const StyledTextbox(type: 'email'),
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
                const SizedBox(height: 10),
              ],
            ),
            Container(
              width: 325,
              alignment: Alignment.center,
              child: StyledButton(
                  text: 'Sign Up', buttonStyle: 'primary', onPressed: signUp),
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
                      onPressed: signUpWithGoogle),
                  StyledButton(
                      icon: Logos.facebookLogo,
                      buttonStyle: 'circle',
                      onPressed: signUpWithFacebook),
                  StyledButton(
                      icon: Logos.twitterLogo,
                      buttonStyle: 'circle',
                      onPressed: signUpWithTwitter),
                ],
              ),
            ),
            Container(
              width: 325,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const StyledText(
                    text: 'Already have an account? ',
                    size: 18,
                  ),
                  StyledButton(
                      text: "Log In",
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
