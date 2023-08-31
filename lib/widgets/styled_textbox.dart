import 'package:flutter/material.dart';

class StyledTextbox extends StatelessWidget {
  const StyledTextbox(this.type, {Key? key}) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    final bool isUsername = type == 'username';
    final bool isPassword = type == 'password';

    return TextField(
      style: const TextStyle(fontSize: 16),
      obscureText: isPassword,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
        border: InputBorder.none,
      ),
    );
  }
}
