import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:letmecook/widgets/textField.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/pages/post_page.dart';
import 'package:letmecook/pages/profile_page.dart';
import 'package:letmecook/pages/search_page.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/textField.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/widgets/wall_post.dart';
import 'package:letmecook/widgets/topAppBar.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final textController = TextEditingController();

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser!.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
      });
    }

    // Clear Text after sending
    setState(() {
      textController.clear();
    });

    print(textController.text);
  }

  void attachImage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 25, right: 25),

          //BOX DECORATION
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
            padding: const EdgeInsets.all(15),

            // PROFILE PICTURE
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[400]),
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                // POST MESSAGE
                Expanded(
                    child: MyTextField(
                  minLines: 1,
                  controller: textController,
                  hintText: 'Post a new recipe!',
                  obscureText: false,
                )),

                // POST BUTTON
                IconButton(
                    onPressed: postMessage,
                    icon: const Icon(Icons.arrow_circle_up)),
                IconButton(
                    onPressed: attachImage,
                    icon: const Icon(Icons.camera_alt_rounded))
              ],
            ),
          ),
        ),
      ],
    )));
  }
}
