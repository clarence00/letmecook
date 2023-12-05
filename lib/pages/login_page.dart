import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letmecook/pages/forgotpw_page.dart';
import 'package:letmecook/widgets/styled_button.dart';
import 'package:letmecook/widgets/styled_textbox.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/auth.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  void forgotPassword() {
    print('Forgot password');
  }

  String? errorMessage = '';
  bool isLogin = true;
  bool usernameError = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.message == 'Error') {
          errorMessage = 'Email or password is incorrect!';
        } else {
          errorMessage = e.message;
        }
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    if (_controllerUsername.text.isEmpty) {
      setState(() {
        usernameError = true;
        errorMessage = 'Username cannot be empty!';
      });
      return;
    }

    if (_controllerUsername.text.contains(' ')) {
      setState(() {
        usernameError = true;
        errorMessage = 'Username cannot contain spaces!';
      });
      return;
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('Usernames')
        .where('Username', isEqualTo: _controllerUsername.text)
        .get();

    if (querySnapshot.docs.isEmpty) {
      errorMessage = '';
      try {
        await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
        );
        await FirebaseFirestore.instance
            .collection('Usernames')
            .doc(_controllerEmail.text)
            .set({
          'Bookmarks': [],
          'Username': _controllerUsername.text,
          'UserEmail': _controllerEmail.text,
          'ProfilePicture':
              'https://firebasestorage.googleapis.com/v0/b/letmecook-65d6f.appspot.com/o/images%2Fprofile_pictures%2Fno_profile_pic.jpg?alt=media&token=c3641180-3263-436e-ab63-1fb79066d474', //Here
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message;
        });
      }
    } else {
      setState(() {
        usernameError = true;
        errorMessage = 'Username is already taken!';
      });
    }
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
              child: Container(
                decoration: const BoxDecoration(color: AppColors.dark),
                child: Center(child: Logos.letMeCookLogo),
              ),
            ),
            Expanded(
              flex: isLogin ? 2 : 3,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.centerLeft,
                      child: StyledText(
                        text: isLogin ? 'LOG IN' : 'SIGN UP',
                        size: 42,
                        weight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          isLogin
                              ? const SizedBox(height: 0)
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  child: const StyledText(
                                      text: 'Username', size: 18),
                                ),
                          isLogin
                              ? const SizedBox(height: 0)
                              : StyledTextbox(
                                  controller: _controllerUsername,
                                ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.centerLeft,
                            child: const StyledText(text: 'Email', size: 18),
                          ),
                          StyledTextbox(
                            controller: _controllerEmail,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.centerLeft,
                            child: const StyledText(text: 'Password', size: 18),
                          ),
                          StyledTextbox(
                            controller: _controllerPassword,
                            obscureText: true,
                          ),
                          const SizedBox(height: 10),
                          isLogin
                              ? GestureDetector(
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      StyledText(
                                        text: 'Forgot Password?',
                                        color: AppColors.accent,
                                        size: 18,
                                        weight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordPage(),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          errorMessage != ''
                              ? Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    StyledText(
                                        text: errorMessage!, color: Colors.red),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: StyledButton(
                                text: isLogin ? 'Log In' : 'Sign Up',
                                buttonStyle: 'login',
                                onPressed: isLogin
                                    ? signInWithEmailAndPassword
                                    : createUserWithEmailAndPassword),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 3,
                            color: AppColors.dark,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StyledText(
                              text: isLogin
                                  ? 'Don\'t have an account? '
                                  : 'Already have an account? ',
                              size: 18),
                          StyledButton(
                              text: isLogin ? 'Sign up' : 'Log in',
                              buttonStyle: 'text',
                              onPressed: () {
                                setState(() {
                                  errorMessage = '';
                                  isLogin = !isLogin;
                                });
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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
