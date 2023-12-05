import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/resources/add_data.dart';
import 'package:letmecook/utils.dart';
import 'package:letmecook/widget_tree.dart';
import 'package:letmecook/widgets/styled_container.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_textbox.dart';
import 'package:multiselect/multiselect.dart';

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
  final _controllerDescription = TextEditingController();
  List<TextEditingController> ingredientsController = [TextEditingController()];
  List<TextEditingController> stepsController = [TextEditingController()];

  int currentStep = 1;

  //Variables for Category Dropdown
  final List<String> _categories = [
    'Pork',
    'Chicken',
    'Beef',
    'Fish',
    'Etc.',
    'Below 100 Pesos ',
    'Above 100 Pesos'
  ];
  List<String> _selectedCategories = [];

  void post() {
    List<String> ingredients =
        ingredientsController.map((controller) => controller.text).toList();
    List<String> steps =
        stepsController.map((controller) => controller.text).toList();

    FirebaseFirestore.instance.collection("User Posts").add({
      'UserEmail': currentUser!.email,
      'Title': _controllerTitle.text,
      'Message': _controllerDescription.text,
      'ImageUrl': imgURL,
      'Category': _selectedCategories,
      'Ingredients': ingredients,
      'Steps': steps,
      'Likes': [],
      'BookmarkCount': 0,
      'TimeStamp': Timestamp.now(),
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WidgetTree()),
    );
  }

  //Image Attachment
  String imgURL = '';
  PlatformFile? pickedFile;
  Widget? fromPicker;
  Uint8List? _image;
  bool uploadImageError = false;
  bool uploadImageSuccess = false;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void uploadImage() async {
    try {
      String? response = await StoreData().saveDataPost(
        file: _image!,
        title: _controllerTitle.text,
        email: currentUser!.email,
        fileName: fileName,
      );
      imgURL = response!;
      setState(() {
        uploadImageSuccess = true;
      });
    } catch (e) {
      setState(() {
        uploadImageError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Title and Category Div
            currentStep == 1
                ? Column(
                    children: [
                      // Page 1/3 Div
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.light,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.dark.withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const StyledText(
                              text: "Page 1/3",
                              color: AppColors.dark,
                              size: 20,
                              weight: FontWeight.w700,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_controllerTitle.text.trim().isNotEmpty &&
                                    _controllerDescription.text
                                        .trim()
                                        .isNotEmpty &&
                                    _selectedCategories.isNotEmpty &&
                                    _image != null) {
                                  uploadImage();
                                  setState(() {
                                    currentStep += 1;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const StyledText(
                                  text: 'Next',
                                  size: 16,
                                  weight: FontWeight.w700,
                                  color: AppColors.dark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      StyledContainer(
                        child: Column(
                          children: [
                            // Title Box
                            StyledTextbox(
                              text: _controllerTitle.text,
                              controller: _controllerTitle,
                              weight: FontWeight.w700,
                              size: 20,
                              hintText: 'Add Title',
                            ),

                            // Category Box
                            const SizedBox(height: 10),
                            Container(
                              decoration: ShapeDecoration(
                                color: AppColors.background,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: DropDownMultiSelect(
                                decoration: const InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none),
                                options: _categories,
                                selectedValues: _selectedCategories,
                                onChanged: (value) {
                                  print('Selected categories $value');
                                  setState(() {
                                    _selectedCategories = value;
                                  });
                                  print(
                                      'You have selected $_selectedCategories');
                                },
                                whenEmpty: 'Please Select a Category!',
                                selected_values_style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.dark,
                                ),
                              ),
                            ),

                            // Description Box
                            const SizedBox(height: 10),
                            StyledTextbox(
                              text: _controllerDescription.text,
                              controller: _controllerDescription,
                              weight: FontWeight.w400,
                              size: 15,
                              hintText: 'Add Description',
                            ),
                            const SizedBox(height: 10),

                            _image != null
                                ? Center(
                                    // child: Container(
                                    //   margin: const EdgeInsets.only(top: 10),
                                    //   // padding: const EdgeInsets.all(15),
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(16),
                                    //   ),
                                    //   child: ClipRRect(
                                    //     borderRadius: BorderRadius.circular(16),
                                    //     child: Image(
                                    //       image: MemoryImage(_image!),
                                    //     ),
                                    //   ),
                                    // ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image(
                                        image: MemoryImage(_image!),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.accent,
                                      foregroundColor: AppColors.dark),
                                  onPressed: selectImage,
                                  icon: const Icon(Icons.camera),
                                  label: const Text('Attach an image!')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : currentStep == 2
                    ?
                    // Ingredients Div -------------------------------------------------------
                    Column(
                        children: [
                          // Page 2/3 Div
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.light,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.dark.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const StyledText(
                                  text: "Page 2/3",
                                  color: AppColors.dark,
                                  size: 20,
                                  weight: FontWeight.w700,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentStep--;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.background,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const StyledText(
                                      text: 'Back',
                                      size: 16,
                                      weight: FontWeight.w700,
                                      color: AppColors.dark,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      ingredientsController
                                          .add(TextEditingController());
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const StyledText(
                                      text: 'Add',
                                      size: 16,
                                      weight: FontWeight.w700,
                                      color: AppColors.dark,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (ingredientsController.every(
                                        (controller) =>
                                            controller.text.trim() != '')) {
                                      setState(() {
                                        currentStep += 1;
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const StyledText(
                                      text: 'Next',
                                      size: 16,
                                      weight: FontWeight.w700,
                                      color: AppColors.dark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Ingredients Div
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              color: AppColors.light,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.dark.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
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
                                  itemCount: ingredientsController.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: ShapeDecoration(
                                                color: AppColors.background,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: TextFormField(
                                                maxLines: null,
                                                controller:
                                                    ingredientsController[
                                                        index],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.dark,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                  border: InputBorder.none,
                                                  hintText: 'Add Ingredients',
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (ingredientsController.length > 1)
                                            const SizedBox(width: 10),
                                          if (ingredientsController.length > 1)

                                            // Remove button
                                            GestureDetector(
                                              onTap: () {
                                                setState(
                                                  () {
                                                    ingredientsController
                                                        .removeAt(index);
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: AppColors.background,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Center(
                                                  child: StyledText(
                                                    text: '-',
                                                    size: 16,
                                                    weight: FontWeight.w400,
                                                    color: AppColors.dark,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    :
                    // Page 3/3 Div
                    Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.light,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.dark.withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const StyledText(
                                  text: "Page 3/3",
                                  color: AppColors.dark,
                                  size: 20,
                                  weight: FontWeight.w700,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentStep--;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.background,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const StyledText(
                                      text: 'Back',
                                      size: 16,
                                      weight: FontWeight.w700,
                                      color: AppColors.dark,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      stepsController
                                          .add(TextEditingController());
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const StyledText(
                                      text: 'Add',
                                      size: 16,
                                      weight: FontWeight.w700,
                                      color: AppColors.dark,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (stepsController.every((controller) =>
                                        controller.text.trim() != '')) {
                                      post();
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const StyledText(
                                      text: 'Post',
                                      size: 16,
                                      weight: FontWeight.w700,
                                      color: AppColors.dark,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          // Steps Div
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
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
                                  text: 'Steps',
                                  size: 20,
                                  weight: FontWeight.w700,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: stepsController.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: AppColors.background,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: StyledText(
                                                text: '${index + 1}',
                                                size: 16,
                                                weight: FontWeight.w400,
                                                color: AppColors.dark,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Container(
                                              decoration: ShapeDecoration(
                                                color: AppColors.background,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: TextFormField(
                                                maxLines: null,
                                                controller:
                                                    stepsController[index],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.dark,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                  border: InputBorder.none,
                                                  hintText: 'Add Steps',
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (stepsController.length > 1)
                                            const SizedBox(width: 10),
                                          if (stepsController.length > 1)
                                            // Remove button
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  stepsController
                                                      .removeAt(index);
                                                });
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: AppColors.background,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Center(
                                                  child: StyledText(
                                                    text: '-',
                                                    size: 16,
                                                    weight: FontWeight.w400,
                                                    color: AppColors.dark,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
