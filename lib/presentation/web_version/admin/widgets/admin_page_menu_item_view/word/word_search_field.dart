import 'package:flutter/material.dart';
import 'package:note_book_app/common/colors/app_colors.dart';

class WordSearchField extends StatelessWidget {
  final String hint;
  final TextEditingController searchController;
  final void Function() onSearch;

  const WordSearchField({
    super.key,
    required this.searchController,
    required this.hint,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) => onSearch(),
      cursorColor: AppColors.black,
      controller: searchController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.kF8EDE3,
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
          fontSize: 16,
        ),
        hintText: hint,
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: Icon(
              Icons.search,
              color: AppColors.black.withOpacity(0.4),
            ),
            onPressed: onSearch,
          ),
        ),
      ),
    );
  }
}
