import 'package:flutter/material.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/styled_container.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_textbox.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

// Variable for UI only (should be changed accordingly)
final _controllerSearch = TextEditingController();

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StyledContainer(
              child: StyledTextbox(
                controller: _controllerSearch,
                hintText: 'Search',
              ),
            ),
            const StyledContainer(
                child: StyledText(
              text: 'Basta mga tao ito',
            ))
          ],
        ),
      ),
    );
  }
}
