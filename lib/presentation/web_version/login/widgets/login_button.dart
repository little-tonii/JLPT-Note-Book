import 'package:flutter/material.dart';
import 'package:note_book_app/common/colors/app_colors.dart';

class LoginButton extends StatelessWidget {
  final void Function() onPressed;

  const LoginButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 20,
            ),
          ),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          overlayColor:
              WidgetStatePropertyAll(AppColors.white.withOpacity(0.08)),
          backgroundColor: const WidgetStatePropertyAll(AppColors.kD0B8A8),
        ),
        onPressed: onPressed,
        child: Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.black.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
