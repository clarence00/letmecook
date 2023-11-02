import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

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
  bool uploadPhotoError = false;
  bool uploadPhotoSuccess = false;
  String errorMessage = '';
  late String username = '';
  String profilePicURL = '';
  PlatformFile? pickedFile;

  void toWidgetTree() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WidgetTree()),
    );
  }

  void selectPhoto() async {}

  void uploadPhoto() async {}

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
    uploadPhotoError = false;
    uploadPhotoSuccess = false;
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
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.light,
                    borderRadius: BorderRadius.circular(100),
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
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 64,
                              child: pickedFile != null
                                  ? Image.file(File(pickedFile!.path!),
                                      fit: BoxFit.cover)
                                  : const Text('None'),
                            ),
                            Positioned(
                              bottom: -10,
                              left: 80,
                              child: IconButton(
                                onPressed: selectPhoto,
                                icon: const Icon(Icons.add_a_photo),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              uploadPhotoError
                  ? const StyledText(
                      text: 'Unable to upload!',
                      size: 16,
                      color: Colors.red,
                    )
                  : uploadPhotoSuccess
                      ? const StyledText(
                          text: 'Photo uploaded!',
                          size: 16,
                          color: Colors.green,
                        )
                      : const SizedBox(height: 0),
              const SizedBox(height: 10),
              StyledButton(
                text: 'Upload',
                size: 18,
                buttonStyle: 'primary',
                onPressed: uploadPhoto,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.light,
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
                          size: 18,
                        ),
                      ),
                      StyledTextbox(
                        controller: _controllerUsername,
                        text: username,
                      ),
                      usernameError
                          ? const StyledText(
                              text: 'Username is already taken!',
                              size: 16,
                              color: Colors.red,
                            )
                          : usernameSuccess
                              ? const StyledText(
                                  text: 'Username changed!',
                                  size: 16,
                                  color: Colors.green,
                                )
                              : const SizedBox(height: 0),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: StyledButton(
                          onPressed: saveUsername,
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
                    color: AppColors.light,
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
                          size: 18,
                        ),
                      ),
                      const StyledText(
                        text: 'Old Password',
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      StyledTextbox(
                        controller: _controllerOldPassword,
                        obscureText: true,
                      ),
                      const StyledText(
                        text: 'New Password',
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      StyledTextbox(
                        controller: _controllerNewPassword,
                        obscureText: true,
                      ),
                      passwordError
                          ? StyledText(
                              text: errorMessage,
                              size: 16,
                              color: Colors.red,
                            )
                          : passwordSuccess
                              ? const StyledText(
                                  text: 'Password changed!',
                                  size: 16,
                                  color: Colors.green,
                                )
                              : const SizedBox(height: 0),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: StyledButton(
                          onPressed: changePassword,
                          text: 'Change Password',
                          size: 18,
                          buttonStyle: 'primary',
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
