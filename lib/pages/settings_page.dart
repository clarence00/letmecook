import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/utils.dart';
import 'package:letmecook/widget_tree.dart';
import 'package:letmecook/widgets/styled_container.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_button.dart';
import 'package:letmecook/widgets/styled_textbox.dart';
import 'package:letmecook/widgets/top_appbar.dart';
import 'package:letmecook/resources/add_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

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
  bool uploadImageError = false;
  bool uploadImageSuccess = false;
  String errorMessage = '';
  String username = '';
  String profilePictureUrl = '';
  String profilePicURL = '';
  PlatformFile? pickedFile;
  Widget? fromPicker;
  Uint8List? _image;

  void toWidgetTree() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WidgetTree()),
    );
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void uploadImage() async {
    try {
      String? response = await StoreData().saveData(
          file: _image!,
          username: username,
          email: currentUser!.email,
          fileName: fileName);
      setState(() {
        uploadImageSuccess = true;
      });
    } catch (e) {
      setState(() {
        uploadImageError = true;
      });
    }
  }

  void saveUsername() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Usernames')
        .where('Username', isEqualTo: _controllerUsername.text)
        .get();

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
    fetchUserData();
    usernameError = false;
    usernameSuccess = false;
    passwordError = false;
    passwordSuccess = false;
    uploadImageError = false;
    uploadImageSuccess = false;
  }

  void fetchUserData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Usernames')
        .doc(currentUser!.email)
        .get();
    setState(() {
      username = snapshot.data()?['Username'] ?? currentUser!.email;
      profilePictureUrl =
          snapshot.data()?['ProfilePicture'] ?? currentUser!.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StyledContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    alignment: Alignment.center,
                    child: _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : profilePictureUrl != ''
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage:
                                    NetworkImage(profilePictureUrl),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundColor: AppColors.light,
                                child: CircularProgressIndicator(),
                              ),
                  ),
                  uploadImageError
                      ? const StyledText(
                          text: 'Unable to upload!',
                          size: 16,
                          color: Colors.red,
                        )
                      : uploadImageSuccess
                          ? const StyledText(
                              text: 'Image uploaded!',
                              size: 16,
                              color: Colors.green,
                            )
                          : const SizedBox(height: 0),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: StyledButton(
                      text: 'Select Image',
                      size: 20,
                      buttonStyle: 'primary',
                      onPressed: selectImage,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: StyledButton(
                      text: 'Upload',
                      size: 20,
                      buttonStyle: 'primary',
                      onPressed: uploadImage,
                    ),
                  ),
                ],
              ),
            ),
            // Username Div
            StyledContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5, bottom: 5),
                    child: const StyledText(
                      text: 'Username',
                      size: 20,
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
                    margin: const EdgeInsets.only(top: 10, bottom: 5),
                    child: StyledButton(
                      onPressed: saveUsername,
                      text: 'Save',
                      size: 20,
                      buttonStyle: 'primary',
                    ),
                  ),
                ],
              ),
            ),
            // Change Password Div
            StyledContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5, bottom: 5),
                    child: const StyledText(
                      text: 'Change Password',
                      size: 20,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5, top: 5),
                    child: const StyledText(
                      text: 'Old Password',
                      size: 16,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: StyledTextbox(
                      controller: _controllerOldPassword,
                      obscureText: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5, top: 5),
                    child: const StyledText(
                      text: 'New Password',
                      size: 16,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: StyledTextbox(
                      controller: _controllerNewPassword,
                      obscureText: true,
                    ),
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
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: StyledButton(
                      onPressed: changePassword,
                      text: 'Change Password',
                      size: 20,
                      buttonStyle: 'primary',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
