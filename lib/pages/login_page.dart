import 'package:flutter/material.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/styled_button.dart';

const backgroundColor = Color.fromRGBO(50, 61, 61, 1);
const windowColor = Color.fromRGBO(242, 241, 230, 1);

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: windowColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            StyledText('LET ME COOK', 'h1'),
            StyledText('Let Me Cook', 'button-text'),
            StyledText('Let Me Cook', 'button'),
            StyledText('Let Me Cook', 'p'),
            StyledButton('Let Me Cook', 'primary')
          ],
        ),
      ),
    );
  }
}
