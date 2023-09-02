import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:letmecook/assets/themes/app_colors.dart';

class Logos {
  static final Widget letMeCookLogo = SvgPicture.asset(
    'lib/assets/icons/letmecook_logo.svg',
    semanticsLabel: 'Let Me Cook Logo',
    color: AppColors.light,
  );

  static final Widget letMeCookLogoSmall = SvgPicture.asset(
    'lib/assets/icons/letmecook_logo.svg',
    semanticsLabel: 'Let Me Cook Logo',
    color: AppColors.light,
    width: 40,
    height: 40,
  );

  static final Widget googleLogo = SvgPicture.asset(
    'lib/assets/icons/google_logo.svg',
    semanticsLabel: 'Google Logo',
    width: 30,
    height: 30,
  );

  static final Widget facebookLogo = SvgPicture.asset(
    'lib/assets/icons/facebook_logo.svg',
    semanticsLabel: 'Facebook Logo',
    width: 30,
    height: 30,
  );

  static final Widget twitterLogo = SvgPicture.asset(
    'lib/assets/icons/twitter_logo.svg',
    semanticsLabel: 'Twitter Logo',
    width: 30,
    height: 30,
  );
}
