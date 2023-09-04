import 'package:flutter/material.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_button.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';

class Footer extends StatelessWidget {
  const Footer({
    this.page = 'home',
    Key? key,
  }) : super(key: key);

  final String page;

  void toHome() {
    print('To home');
  }

  void toSearch() {
    print('To search');
  }

  void toProfile() {
    print('To profile');
  }

  @override
  Widget build(context) {
    if (page == 'home') {
      return _buildHomeFooter();
    } else if (page == 'search') {
      return _buildSearchFooter();
    } else {
      return _buildProfileFooter();
    }
  }

  Widget _buildHomeFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: const BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CustomIcons.home(color: AppColors.dark),
                const SizedBox(width: 8),
                const StyledText(
                  text: 'Home',
                  size: 20,
                  weight: FontWeight.w700,
                )
              ],
            ),
          ),
          StyledButton(
            buttonStyle: 'icon',
            icon: CustomIcons.search(color: AppColors.light),
            onPressed: toSearch,
          ),
          StyledButton(
            buttonStyle: 'icon',
            icon: CustomIcons.profile(color: AppColors.light),
            onPressed: toProfile,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: const BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StyledButton(
            buttonStyle: 'icon',
            icon: CustomIcons.home(color: AppColors.light),
            onPressed: toHome,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CustomIcons.search(color: AppColors.dark),
                const SizedBox(width: 8),
                const StyledText(
                  text: 'Search',
                  size: 20,
                  weight: FontWeight.w700,
                )
              ],
            ),
          ),
          StyledButton(
            buttonStyle: 'icon',
            icon: CustomIcons.profile(color: AppColors.light),
            onPressed: toProfile,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: const BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StyledButton(
            buttonStyle: 'icon',
            icon: CustomIcons.home(color: AppColors.light),
            onPressed: toHome,
          ),
          StyledButton(
            buttonStyle: 'icon',
            icon: CustomIcons.search(color: AppColors.light),
            onPressed: toSearch,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CustomIcons.profile(color: AppColors.dark),
                const SizedBox(width: 8),
                const StyledText(
                  text: 'Profile',
                  size: 20,
                  weight: FontWeight.w700,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
