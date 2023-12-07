import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/pages/profile_page.dart';
import 'package:letmecook/pages/searchedprofile_page.dart';
import 'package:letmecook/widgets/styled_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

// Variable for UI only (should be changed accordingly)

class _SearchPageState extends State<SearchPage> {
  String username = "";

  void toProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  void toSearchedUserProfile(String searchedUserEmail) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SearchedProfilePage(searchedUser: searchedUserEmail)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    style: GoogleFonts.poppins(
                      color: AppColors.dark,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: AppColors.dark,
                        size: 24,
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(
                        () {
                          username = value;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.dark,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: StyledText(
                                text: 'Post', color: AppColors.light),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: StyledText(
                                text: 'People', color: AppColors.dark),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: StyledText(
                                text: 'Category', color: AppColors.dark),
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // People
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Usernames')
                  .snapshots(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: ((context, index) {
                          var data = snapshots.data!.docs[index].data()
                              as Map<String, dynamic>;

                          if (data['Username']
                                  .toString()
                                  .startsWith(username.toLowerCase()) &&
                              username.isNotEmpty) {
                            return GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
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
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(data['ProfilePicture']),
                                      radius: 25,
                                    ),
                                    const SizedBox(width: 15),
                                    StyledText(
                                      text: data['Username'],
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                toSearchedUserProfile(data['UserEmail']);
                              },
                            );
                          }
                          return Container();
                        }),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
