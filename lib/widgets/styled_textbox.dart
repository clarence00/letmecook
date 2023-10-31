import 'package:flutter/material.dart';

class StyledTextbox extends StatelessWidget {
  const StyledTextbox(
      {Key? key, this.type = 'text', this.text = '', required this.controller})
      : super(key: key);

  final TextEditingController controller;
  final String type;
  final String text;

  @override
  Widget build(BuildContext context) {
    final bool isPassword = type == 'password';
    controller.text = text;

    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 16),
      obscureText: isPassword,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
        border: InputBorder.none,
      ),
    );
  }
}
