import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hint,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // ✨ عشان نقدر نتحكم في النص
      cursorColor: kPrimaryColor,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: kPrimaryColor),
        border: _buildBorder(),
        enabledBorder: _buildBorder(kPrimaryColor),
        focusedBorder: _buildBorder(kPrimaryColor),
      ),
    );
  }

  OutlineInputBorder _buildBorder([Color color = Colors.white]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }
}
