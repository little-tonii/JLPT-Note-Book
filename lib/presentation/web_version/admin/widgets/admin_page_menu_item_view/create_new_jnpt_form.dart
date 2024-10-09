import 'package:flutter/material.dart';
import 'package:note_book_app/common/colors/app_colors.dart';

class CreateNewJnptForm extends StatelessWidget {
  const CreateNewJnptForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 800,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.kF8EDE3,
      ),
    );
  }
}
