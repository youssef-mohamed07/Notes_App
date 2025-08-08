import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;

  const CustomTextField({
    super.key,
    required this.hint,
    this.maxLines = 1,
    this.controller,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // للتحكم بالنص
      cursorColor: kPrimaryColor,
      maxLines: maxLines,
      onSaved: onSaved, // تخزين القيمة عند الحفظ
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '$hint is required';
        }
        return null;
      },
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
