import 'package:flutter/material.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_button.dart';
import 'package:letmecook/widgets/styled_textbox.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/pages/signup_page.dart';

const backgroundColor = AppColors.dark;
const windowColor = AppColors.light;

void toSignUp(context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => const SignUpPage()));
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(color: backgroundColor),
                child: Center(child: Logos.letMeCookLogo),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: windowColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 10),
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
                          margin: EdgeInsets.symmetric(vertical: 10),
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
                          margin: EdgeInsets.symmetric(vertical: 10),
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
                          child: const StyledButton(
                              text: 'Forgot Password?', buttonStyle: 'text'),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    Container(
                      width: 325,
                      alignment: Alignment.center,
                      child: const StyledButton(
                          text: 'Log In', buttonStyle: 'primary'),
                    ),
                    Container(
                      width: 325,
                      height: 3,
                      color: AppColors.dark, // Customize color
                      margin: const EdgeInsets.symmetric(
                          vertical: 10), // Customize margin
                    ),
                    Container(
                      width: 325,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          StyledButton(
                              icon: Logos.googleLogo, buttonStyle: 'circle'),
                          StyledButton(
                              icon: Logos.facebookLogo, buttonStyle: 'circle'),
                          StyledButton(
                              icon: Logos.twitterLogo, buttonStyle: 'circle'),
                        ],
                      ),
                    ),
                    Container(
                      width: 325,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          StyledText('Don\'t have an account yet? ', 'h3'),
                          StyledButton(text: "Sign up", buttonStyle: 'text'),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
