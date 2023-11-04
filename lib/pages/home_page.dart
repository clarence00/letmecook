import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  // CODE PROPER

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: botNav,

      backgroundColor: Colors.grey[300],
      //appBar: _appBar,

      // WALL POST
      body: Center(
        child: Container(
          child:

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
                          user: post['UserEmail'],
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
          // Logged in as : section
        ),
      ),
    );
  }
}
