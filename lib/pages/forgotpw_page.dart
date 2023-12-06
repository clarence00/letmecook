import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/utils.dart';
import 'package:letmecook/widget_tree.dart';
import 'package:letmecook/widgets/styled_button.dart';
import 'package:letmecook/widgets/styled_text.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? emailError;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void validateEmail(String email) {
    if (email.isNotEmpty && !EmailValidator.validate(email)) {
      setState(() {
        emailError = 'Enter a valid email';
      });
    } else {
      setState(() {
        emailError = null;
      });
    }
  }

  void backToLogin() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.dark,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dark.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const StyledText(
                text: 'Receive an email to reset your password',
                size: 24,
                color: AppColors.light,
                weight: FontWeight.w700,
                overflow: TextOverflow.clip,
                align: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dark.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5),
                      alignment: Alignment.centerLeft,
                      child: const StyledText(
                        text: 'Email',
                        size: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.background,
                          ),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                            controller: emailController,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.dark,
                            ),
                            onChanged: validateEmail,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (emailError != null)
                          Container(
                            padding: const EdgeInsets.only(left: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              emailError!,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.red,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StyledButton(
                          buttonStyle: 'primary',
                          size: 24,
                          text: 'Back',
                          onPressed: backToLogin,
                        ),
                        StyledButton(
                          buttonStyle: 'primary',
                          size: 24,
                          text: 'Reset Password',
                          onPressed: resetPassword,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: (emailController.text.trim()));
      //insert snackbar or popup to indicate email has been sent
      Utils.showSnackBar('Password Reset Email has been sent.');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => WidgetTree()));
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }
}
