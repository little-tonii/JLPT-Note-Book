import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_book_app/common/colors/app_colors.dart';

class NotFoundPageWeb extends StatelessWidget {
  const NotFoundPageWeb({super.key});

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
      backgroundColor: AppColors.kD0B8A8,
    );
  }
}
