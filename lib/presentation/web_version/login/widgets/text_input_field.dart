import 'package:flutter/material.dart';
import 'package:note_book_app/common/colors/app_colors.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obcureText;

  const TextInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obcureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obcureText,
      cursorColor: AppColors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.kF8EDE3.withOpacity(0.8),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        hintStyle: TextStyle(
          color: AppColors.black.withOpacity(0.4),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        hintText: hintText,
      ),
    );
  }
}
