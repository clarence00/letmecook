import 'package:flutter/material.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/styled_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],


        // LET ME COOK TEXT //
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Logos.letMeCookLogoSmall,
              SizedBox(
                width: 15,
              ),
              StyledText(
                text: 'LET ME COOK',
                color: AppColors.light,
                size: 32,
                weight: FontWeight.w700,

              )
            ],
          ) 
        ),
      ),
    );
  }
}