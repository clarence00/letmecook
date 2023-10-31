import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:letmecook/widgets/textField.dart';
import 'package:letmecook/widgets/topAppBar.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final textController = TextEditingController();

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        //'UserEmail': 'Email@example.com',
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
      });
    }

    //FUNCTIONS

    // Clear Text after sending

    setState(() {
      textController.clear();
    });

    print(textController.text);
  }

  //ATTACH IMAGE
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
      )),
    );
  }
}
