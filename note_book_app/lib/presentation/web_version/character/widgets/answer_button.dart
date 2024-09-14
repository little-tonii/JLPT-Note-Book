import 'package:flutter/material.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';

class AnswerButton extends StatelessWidget {
  final String answer;

  const AnswerButton({super.key, required this.answer});

  void _handleAnswer(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            vertical: ResponsiveUtil.isMobile(context) ? 16 : 24,
          ),
        ),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        overlayColor: WidgetStatePropertyAll(AppColors.black.withOpacity(0.08)),
        backgroundColor: const WidgetStatePropertyAll(AppColors.kF8EDE3),
      ),
      onPressed: () => _handleAnswer(context),
      child: Text(
        answer,
        style: TextStyle(
          fontSize: ResponsiveUtil.isDesktop(context)
              ? 32
              : ResponsiveUtil.isTablet(context)
                  ? 24
                  : 16,
          color: AppColors.black.withOpacity(0.4),
        ),
      ),
    );
  }
}
