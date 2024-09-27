import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';

class LessonCard extends StatelessWidget {
  final LessonEntity lesson;

  const LessonCard({super.key, required this.lesson});

  void _handleOnTapDetailCard(BuildContext context) {
    context.go(
        "/home/${GoRouterState.of(context).pathParameters['levelId']}/${lesson.id}");
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleOnTapDetailCard(context),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.kD0B8A8,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "${lesson.level} | ${lesson.lesson}",
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
        ),
      ),
    );
  }
}
