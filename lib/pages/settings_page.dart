import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/pages/post_page.dart';
import 'package:letmecook/pages/profile_page.dart';
import 'package:letmecook/pages/search_page.dart';
import 'package:letmecook/pages/hub_page.dart';
import 'package:letmecook/widget_tree.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_button.dart';
import 'package:letmecook/widgets/styled_textbox.dart';
import 'package:letmecook/widgets/text_field.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/widgets/wall_post.dart';
import 'package:letmecook/widgets/top_appbar.dart';
import 'package:letmecook/auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerOldPassword = TextEditingController();
  final TextEditingController _controllerNewPassword = TextEditingController();
  bool usernameError = false;
  bool passwordError = false;
  bool usernameSuccess = false;
  bool passwordSuccess = false;
  String errorMessage = '';
  late String username = '';

  void toWidgetTree() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WidgetTree()),
    );
  }

  void saveUsername() async {
    // Check if the username already exists
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Usernames')
        .where('Username', isEqualTo: _controllerUsername.text)
        .get();

    // If the result is empty or the username is still the same
    if (querySnapshot.docs.isEmpty ||
        querySnapshot.docs.first.get('Username') == username) {
      await FirebaseFirestore.instance
          .collection('Usernames')
          .doc(currentUser!.email)
          .set({
        'Username': _controllerUsername.text,
        'UserEmail': currentUser!.email,
      });
      setState(() {
        username = _controllerUsername.text;
        usernameError = false;
        usernameSuccess = true;
      });
    } else {
      setState(() {
        usernameError = true;
      });
    }
  }

  void changePassword() async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: _controllerOldPassword.text,
      );
      await currentUser!.reauthenticateWithCredential(credential);
      await currentUser!.updatePassword(_controllerNewPassword.text);
      setState(() {
        passwordError = false;
        passwordSuccess = true;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        passwordError = true;
        if (e.message == 'Error') {
          errorMessage = 'Wrong password!';
        } else {
          errorMessage = e.message ?? 'An error occurred';
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsername();
    usernameError = false;
    usernameSuccess = false;
    passwordError = false;
    passwordSuccess = false;
  }

  void fetchUsername() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Usernames')
        .doc(currentUser!.email)
        .get();
    setState(() {
      username = snapshot.data()?['Username'] ?? currentUser!.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: const StyledText(
                          text: 'Username',
                          size: 20,
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: ShapeDecoration(
                          color: AppColors.background,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: StyledTextbox(
                          controller: _controllerUsername,
                          text: username,
                          type: 'username',
                        ),
                      ),
                      usernameError
                          ? const StyledText(
                              text: 'Username is already taken!',
                              color: Colors.red,
                            )
                          : usernameSuccess
                              ? const StyledText(
                                  text: 'Username changed!',
                                  color: Colors.green,
                                )
                              : const SizedBox(height: 0),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: StyledButton(
                          onPressed: saveUsername,
                          icon: const Icon(Icons.check),
                          text: 'Save',
                          size: 18,
                          buttonStyle: 'primary',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const StyledText(
                          text: 'Change Password',
                          size: 20,
                        ),
                      ),
                      const StyledText(
                        text: 'Old Password',
                        weight: FontWeight.bold,
                      ),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(top: 10, bottom: 15),
                        decoration: ShapeDecoration(
                          color: AppColors.background,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: StyledTextbox(
                          controller: _controllerOldPassword,
                          type: 'password',
                        ),
                      ),
                      const StyledText(
                        text: 'New Password',
                        weight: FontWeight.bold,
                      ),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: ShapeDecoration(
                          color: AppColors.background,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: StyledTextbox(
                          controller: _controllerNewPassword,
                          type: 'password',
                        ),
                      ),
                      passwordError
                          ? StyledText(
                              text: errorMessage,
                              color: Colors.red,
                            )
                          : passwordSuccess
                              ? const StyledText(
                                  text: 'Password changed!',
                                  color: Colors.green,
                                )
                              : const SizedBox(height: 0),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: StyledButton(
                          onPressed: changePassword,
                          icon: const Icon(Icons.check),
                          text: 'Change Password',
                          size: 18,
                          buttonStyle: 'primary',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: IconButton(
                          onPressed: toWidgetTree,
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const StyledText(
                            text: 'Back',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
