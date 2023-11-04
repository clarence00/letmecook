import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/assets/themes/app_colors.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.post,
    required this.user,
  });

  // Variables
  final String post;
  final String user;

  final Color _heartColor = AppColors.dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // First Div (Profile)
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: CustomIcons.profile(
                  color: AppColors.dark,
                  size: 40,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        user,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.dark),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Icon(
                        Icons.circle_rounded,
                        color: AppColors.accent,
                        size: 8,
                      ),
                    ),
                    Text(
                      "12 hrs",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.accent),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.more_vert,
                color: AppColors.dark,
                size: 24,
              ),
            ],
          ),
          // Second Div (Title)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              post,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark),
            ),
          ),
          // Third Div (Image)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://picsum.photos/id/1074/400/400',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Fourth Div (Reacts)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: CustomIcons.heart(color: _heartColor),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      "12",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: CustomIcons.comment(color: _heartColor),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      "12",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: CustomIcons.bookmark(color: _heartColor),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      "12",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.dark,
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
