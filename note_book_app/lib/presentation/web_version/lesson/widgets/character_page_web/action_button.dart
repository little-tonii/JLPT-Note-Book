import 'package:flutter/material.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final void Function(BuildContext) onPressed;

  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
        ),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        overlayColor: WidgetStatePropertyAll(AppColors.black.withOpacity(0.08)),
        backgroundColor: const WidgetStatePropertyAll(AppColors.kF8EDE3),
      ),
      onPressed: () => onPressed(context),
      child: Text(
        text,
        style: TextStyle(
          fontSize: ResponsiveUtil.isDesktop(context)
              ? 24
              : ResponsiveUtil.isTablet(context)
                  ? 20
                  : 16,
          color: AppColors.black.withOpacity(0.4),
        ),
      ),
    );
  }
}
