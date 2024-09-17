import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';

class NotFoundPageWeb extends StatelessWidget {
  const NotFoundPageWeb({super.key});

  void _handleOnTapNavigateToHome(BuildContext context) {
    context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setApplicationSwitcherDescription(
        const ApplicationSwitcherDescription(
          label: "Page Not Found",
        ),
      );
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Trang không tồn tại",
              style: TextStyle(
                fontSize: ResponsiveUtil.isDesktop(context)
                    ? 32
                    : ResponsiveUtil.isTablet(context)
                        ? 24
                        : 20,
                fontWeight: FontWeight.bold,
                color: AppColors.kD0B8A8,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                overlayColor:
                    WidgetStatePropertyAll(AppColors.black.withOpacity(0.08)),
                backgroundColor:
                    const WidgetStatePropertyAll(AppColors.kF8EDE3),
              ),
              onPressed: () => _handleOnTapNavigateToHome(context),
              child: Text(
                "Về trang chủ",
                style: TextStyle(
                  fontSize: ResponsiveUtil.isDesktop(context)
                      ? 24
                      : ResponsiveUtil.isTablet(context)
                          ? 20
                          : 16,
                  color: AppColors.black.withOpacity(0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
