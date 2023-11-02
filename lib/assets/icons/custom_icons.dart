import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:letmecook/assets/themes/app_colors.dart';

class CustomIcons {
  static Widget arrowRight({Color? color}) {
    return SvgPicture.asset(
      'lib/assets/icons/custom_icons/arrow_right.svg',
      semanticsLabel: 'Arrow Right',
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      height: 30,
      width: 30,
    );
  }

  static Widget heart({Color? color}) {
    return SvgPicture.asset(
      'lib/assets/icons/custom_icons/heart.svg',
      semanticsLabel: 'Heart',
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      height: 25,
      width: 25,
    );
  }

  static Widget comment({Color? color}) {
    return SvgPicture.asset(
      'lib/assets/icons/custom_icons/comment.svg',
      semanticsLabel: 'Comment',
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      height: 25,
      width: 25,
    );
  }

  static Widget bookmark({Color? color}) {
    return SvgPicture.asset(
      'lib/assets/icons/custom_icons/bookmark.svg',
      semanticsLabel: 'Bookmark',
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      height: 25,
      width: 25,
    );
  }

  static Widget home({Color? color = AppColors.dark}) {
    return SvgPicture.asset(
      'lib/assets/icons/custom_icons/home.svg',
      semanticsLabel: 'Home',
      color: color,
      height: 24,
      width: 24,
    );
  }

  static Widget search({Color? color = AppColors.dark}) {
    return SvgPicture.asset(
      'lib/assets/icons/custom_icons/search.svg',
      semanticsLabel: 'Search',
      color: color,
      height: 24,
      width: 24,
    );
  }

  static Widget profile({Color? color, double? size}) {
    return SvgPicture.asset(
      'lib/assets/icons/custom_icons/profile.svg',
      semanticsLabel: 'Profile',
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      height: size,
      width: size,
    );
  }

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
