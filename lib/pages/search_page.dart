import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/pages/profile_page.dart';
import 'package:letmecook/pages/searchedprofile_page.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/post_tile.dart';
import 'package:multiselect/multiselect.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

// Variable for UI only (should be changed accordingly)

class _SearchPageState extends State<SearchPage> {
  String searchText = "";
  String searchBy = 'Post';
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
                searchBy != 'Category'
                    ? Container(
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
                                searchText = value;
                              },
                            );
                          },
                        ),
                      )
                    : Container(
                        decoration: ShapeDecoration(
                          color: AppColors.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: DropDownMultiSelect(
                          decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none),
                          options: _categories,
                          selectedValues: _selectedCategories,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategories = value;
                            });
                          },
                          whenEmpty: 'Please Select a Category!',
                          selected_values_style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.dark,
                          ),
                        ),
                      ),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            searchBy = 'Post';
                          });
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: searchBy == 'Post'
                                ? AppColors.dark
                                : AppColors.background,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: StyledText(
                                text: 'Post',
                                color: searchBy == 'Post'
                                    ? AppColors.light
                                    : AppColors.dark),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            searchBy = 'People';
                          });
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: searchBy == 'People'
                                ? AppColors.dark
                                : AppColors.background,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: StyledText(
                                text: 'People',
                                color: searchBy == 'People'
                                    ? AppColors.light
                                    : AppColors.dark),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            searchBy = 'Category';
                          });
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: searchBy == 'Category'
                                ? AppColors.dark
                                : AppColors.background,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: StyledText(
                                text: 'Category',
                                color: searchBy == 'Category'
                                    ? AppColors.light
                                    : AppColors.dark),
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
          const SizedBox(height: 10),
          searchBy == 'Post'
              // Search by post
              ? Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('User Posts')
                        .where('SearchKeywords',
                            arrayContainsAny:
                                searchText.toLowerCase().split(' '))
                        .snapshots(),
                    builder: (context, snapshots) {
                      return (snapshots.connectionState ==
                              ConnectionState.waiting)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: snapshots.data!.docs.length,
                              itemBuilder: ((context, index) {
                                var post = snapshots.data!.docs[index];
                                if (searchText.isNotEmpty) {
                                  return PostTile(
                                    title: post['Title'],
                                    user: post['UserEmail'],
                                    timestamp: post['TimeStamp'],
                                    imageUrl: 'imageUrl',
                                    likes:
                                        List<String>.from(post['Likes'] ?? []),
                                    bookmarks: List<String>.from(
                                        post['Bookmarks'] ?? []),
                                    postId: post.id,
                                  );
                                }
                                return Container();
                              }),
                            );
                    },
                  ),
                )
              // Search by people
              : searchBy == 'People'
                  ? Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Usernames')
                            .snapshots(),
                        builder: (context, snapshots) {
                          return (snapshots.connectionState ==
                                  ConnectionState.waiting)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  itemCount: snapshots.data!.docs.length,
                                  itemBuilder: ((context, index) {
                                    var data = snapshots.data!.docs[index]
                                        .data() as Map<String, dynamic>;

                                    if (data['Username'].toString().startsWith(
                                            searchText.toLowerCase()) &&
                                        searchText.isNotEmpty) {
                                      return GestureDetector(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: AppColors.light,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.dark
                                                    .withOpacity(0.25),
                                                spreadRadius: 0,
                                                blurRadius: 15,
                                                offset: const Offset(0, 5),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    data['ProfilePicture']),
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
                                          toSearchedUserProfile(
                                              data['UserEmail']);
                                        },
                                      );
                                    }
                                    return Container();
                                  }),
                                );
                        },
                      ),
                    )
                  // Search by category
                  : searchBy == 'Category'
                      ? Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _selectedCategories.isNotEmpty
                                ? FirebaseFirestore.instance
                                    .collection('User Posts')
                                    .where('Category',
                                        arrayContainsAny: _selectedCategories)
                                    .snapshots()
                                : FirebaseFirestore.instance
                                    .collection('User Posts')
                                    .snapshots(),
                            builder: (context, snapshots) {
                              return (snapshots.connectionState ==
                                      ConnectionState.waiting)
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemCount: snapshots.data!.docs.length,
                                      itemBuilder: ((context, index) {
                                        var post = snapshots.data!.docs[index];
                                        if (_selectedCategories.isNotEmpty) {
                                          return PostTile(
                                            title: post['Title'],
                                            user: post['UserEmail'],
                                            timestamp: post['TimeStamp'],
                                            imageUrl: 'imageUrl',
                                            likes: List<String>.from(
                                                post['Likes'] ?? []),
                                            bookmarks: List<String>.from(
                                                post['Bookmarks'] ?? []),
                                            postId: post.id,
                                          );
                                        }
                                        return Container();
                                      }),
                                    );
                            },
                          ),
                        )
                      : const SizedBox(),
        ],
      ),
    );
  }
}
