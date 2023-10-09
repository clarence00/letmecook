import 'package:flutter/material.dart';


class MyTextField  extends StatelessWidget {
  
  final controller;
  final String hintText;
  final bool obscureText;
  final int minLines;
  final int maxLines;

  const MyTextField ({
    super.key,
    required this.controller,
    required this.hintText,
    required this. obscureText,
    required this. minLines,
    required this. maxLines,
    
    });

  


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          minLines: minLines,
          maxLines: maxLines,
          controller: controller,
          decoration: InputDecoration(
            
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: hintText,
          ),
          ),
      );
  }
}