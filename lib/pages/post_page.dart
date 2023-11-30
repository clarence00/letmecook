import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
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
  final _controllerDescriptions = TextEditingController();
  List<TextEditingController> ingredientControllers = [TextEditingController()];

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
                    ),
                    //description box
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: StyledTextbox(
                          controller: _controllerDescriptions,
                          weight: FontWeight.w400,
                          size: 15,
                          hintText: 'Add Description'),
                    ),
                    GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const StyledText(
                          text: 'Next',
                          size: 16,
                          weight: FontWeight.w600,
                          color: AppColors.dark,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Ingredients Div -------------------------------------------------------
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
                      text: 'Ingredients',
                      size: 20,
                      weight: FontWeight.w700,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: ingredientControllers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: ShapeDecoration(
                                    color: AppColors.background,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: TextFormField(
                                    maxLines: null,
                                    controller: ingredientControllers[index],
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
                              if (ingredientControllers.length > 1)
                                const SizedBox(width: 10),
                              if (ingredientControllers.length > 1)
                                // Remove button
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      ingredientControllers.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.background,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const StyledText(
                                      text: '-',
                                      size: 16,
                                      weight: FontWeight.w600,
                                      color: AppColors.dark,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),

                    // Add more button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              ingredientControllers
                                  .add(TextEditingController());
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const StyledText(
                              text: 'Add',
                              size: 16,
                              weight: FontWeight.w600,
                              color: AppColors.dark,
                            ),
                          ),
                        ),
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
