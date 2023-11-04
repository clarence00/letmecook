import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/styled_button.dart';
import 'package:letmecook/widgets/styled_container.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_textbox.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final textController = TextEditingController();

  // Variable for UI only (should be changed accordingly)
  final bool hasImage = true;
  final _controllerTitle = TextEditingController();
  final _controllerCategory = TextEditingController();
  final _controllerIngredients = TextEditingController();

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser!.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'ImageUrl': '',
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
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Title and Category Div
              StyledContainer(
                child: Column(
                  children: [
                    StyledTextbox(
                      controller: _controllerTitle,
                      weight: FontWeight.w700,
                      size: 20,
                      hintText: 'Add Title',
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: StyledTextbox(
                        controller: _controllerCategory,
                        weight: FontWeight.w700,
                        size: 20,
                        hintText: 'Category',
                      ),
                    )
                  ],
                ),
              ),
              // Ingredients Div
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.light,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.dark.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    const StyledText(
                      text: 'Recipe',
                      size: 20,
                      weight: FontWeight.w700,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.dark,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        decoration: ShapeDecoration(
                          color: AppColors.background,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: TextField(
                          maxLines: null,
                          controller: _controllerIngredients,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.dark,
                          ),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            border: InputBorder.none,
                            hintText: 'Add Ingredients',
                          ),
                        ),
                      ),
                    ),
                    hasImage
                        ? Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                'https://picsum.photos/id/1074/400/400',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : const SizedBox(height: 0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.image_rounded),
                          color: AppColors.dark,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: StyledButton(
                            onPressed: () {},
                            buttonStyle: 'primary',
                            size: 20,
                            text: 'Post',
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
