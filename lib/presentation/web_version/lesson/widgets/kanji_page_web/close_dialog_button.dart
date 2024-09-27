import 'package:flutter/material.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';

class CloseDialogButton extends StatelessWidget {
  final void Function(BuildContext) onPressed;

  const CloseDialogButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            horizontal: ResponsiveUtil.isDesktop(context) ? 32 : 24,
            vertical: ResponsiveUtil.isDesktop(context) ? 16 : 12,
          ),
        ),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        overlayColor: WidgetStatePropertyAll(AppColors.white.withOpacity(0.08)),
        backgroundColor: const WidgetStatePropertyAll(AppColors.kD0B8A8),
      ),
      onPressed: () => onPressed(context),
      child: Text(
        'Đóng',
        style: TextStyle(
          fontWeight: FontWeight.bold,
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
