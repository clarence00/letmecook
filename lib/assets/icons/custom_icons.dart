import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:letmecook/assets/themes/app_colors.dart';

class CustomIcons {
  static final Widget arrowRight = SvgPicture.asset(
    'lib/assets/icons/custom_icons/arrow_right.svg',
    semanticsLabel: 'Arrow Right',
    color: AppColors.dark,
    height: 28,
    width: 28,
  );

  static final Widget heartDark = SvgPicture.asset(
    'lib/assets/icons/custom_icons/heart.svg',
    semanticsLabel: 'Heart Dark',
    color: AppColors.dark,
    height: 24,
    width: 24,
  );

  static final Widget heartAccent = SvgPicture.asset(
    'lib/assets/icons/custom_icons/heart.svg',
    semanticsLabel: 'Heart Accent',
    color: AppColors.accent,
    height: 24,
    width: 24,
  );

  static final Widget comment = SvgPicture.asset(
    'lib/assets/icons/custom_icons/comment.svg',
    semanticsLabel: 'Comment',
    color: AppColors.dark,
    height: 24,
    width: 24,
  );

  static final Widget bookmark = SvgPicture.asset(
    'lib/assets/icons/custom_icons/bookmark.svg',
    semanticsLabel: 'Bookmark',
    color: AppColors.dark,
    height: 24,
    width: 24,
  );

  static final Widget home = SvgPicture.asset(
    'lib/assets/icons/custom_icons/home.svg',
    semanticsLabel: 'Home',
    color: AppColors.light,
    height: 24,
    width: 24,
  );

  static final Widget search = SvgPicture.asset(
    'lib/assets/icons/custom_icons/search.svg',
    semanticsLabel: 'Search',
    color: AppColors.light,
    height: 24,
    width: 24,
  );

  static final Widget profile = SvgPicture.asset(
    'lib/assets/icons/custom_icons/profile.svg',
    semanticsLabel: 'Profile',
    color: AppColors.light,
    height: 24,
    width: 24,
  );

  static final Widget circle = SvgPicture.asset(
    'lib/assets/icons/custom_icons/circle.svg',
    semanticsLabel: 'Circle',
    color: AppColors.dark,
    height: 24,
    width: 24,
  );

  static final Widget arrowDown = SvgPicture.asset(
    'lib/assets/icons/custom_icons/arrow_down.svg',
    semanticsLabel: 'Arrow Down',
    color: AppColors.dark,
    height: 24,
    width: 24,
  );

  static final Widget image = SvgPicture.asset(
    'lib/assets/icons/custom_icons/image.svg',
    semanticsLabel: 'Image',
    color: AppColors.dark,
    height: 32,
    width: 32,
  );

  static final Widget send = SvgPicture.asset(
    'lib/assets/icons/custom_icons/send.svg',
    semanticsLabel: 'Send',
    color: AppColors.dark,
    height: 24,
    width: 24,
  );
}
