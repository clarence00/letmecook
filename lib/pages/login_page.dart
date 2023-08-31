import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:letmecook/widgets/login_widget.dart';
import 'package:letmecook/widgets/signup_widget.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_button.dart';
import 'package:letmecook/widgets/styled_textbox.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/pages/login_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool isLoginView = true;

  void toggleView() {
    setState(() {
      isLoginView = !isLoginView;
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.dark,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(color: AppColors.dark),
                child: Center(child: Logos.letMeCookLogo),
              ),
            ),
            Expanded(
              flex: 3,
              child: isLoginView
                  ? LogInWidget(
                      toggleView:
                          toggleView) // Pass the toggleView function here
                  : SignUpWidget(
                      toggleView:
                          toggleView), // Pass the toggleView function here
            ),
          ],
        ),
      ),
    );
  }
}
