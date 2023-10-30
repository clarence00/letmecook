import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/btmNavBar.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/textField.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/widgets/wall_post.dart';
import 'package:letmecook/widgets/btmNavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Username display (uncomment as needed)
  //final currentUser = FirebaseAuth.instance.currentUser;

  final botNav = btmNavBar();

  //text controller
  final textController = TextEditingController();

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        //'UserEmail': 'Email@example.com',
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
      bottomNavigationBar: botNav,

      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],

        // LET ME COOK TEXT //
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logos.letMeCookLogoSmall,
            SizedBox(
              width: 15,
            ),
            StyledText(
              text: 'LET ME COOK',
              color: AppColors.light,
              size: 32,
              weight: FontWeight.w700,
            )
          ],
        )),
      ),

      // WALL POST
      body: Center(
        child: Container(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 10, left: 25, right: 25),

              //   //BOX DECORATION
              //   child: Container(

              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(25),
              //       boxShadow: [
              //         BoxShadow(
              //          color: Colors.grey.withOpacity(0.5),
              //          spreadRadius: 5,
              //          blurRadius: 7,
              //          offset: Offset(0, 3),
              //         )
              //       ],

              //     ),

              //     margin: const EdgeInsets.symmetric(vertical: 10),
              //     padding: const EdgeInsets.all(15),

              //   // PROFILE PICTURE
              //     child: Row(
              //       children: [
              //         Container(
              //           decoration: BoxDecoration(
              //               shape: BoxShape.circle, color: Colors.grey[400]),
              //           padding: EdgeInsets.all(10),

              //           child: Icon(
              //             Icons.person,
              //             color: Colors.white,
              //           ),
              //         ),
              //   // POST MESSAGE
              //         Expanded(
              //             child: MyTextField(
              //           minLines: 1,
              //           maxLines: 150,
              //           controller: textController,
              //           hintText: 'Post a new recipe!',
              //           obscureText: false,

              //         )
              //         ),

              //         // POST BUTTON
              //         IconButton(
              //             onPressed: postMessage,
              //             icon: const Icon(Icons.arrow_circle_up)),
              //         IconButton(
              //           onPressed: attachImage,
              //           icon: const Icon(Icons.camera_alt_rounded))
              //       ],
              //     ),
              //   ),
              // ),

              // Wall Display (boxes)
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("User Posts")
                      .orderBy(
                        "TimeStamp",
                        descending: false,
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            final post = snapshot.data!.docs[index];
                            return WallPost(
                              message: post['Message'],
                              //user: post['UserEmail'],
                            );
                          }));
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error:' + snapshot.error.toString()),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),

              // Post message section

              // Logged in as : section

              //Text("Logged in as : " + currentUser.email )
            ],
          ),
        ),
      ),
    );
  }
}
