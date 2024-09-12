import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';

class LevelCard extends StatelessWidget {
  final LevelEntity levelEntity;

  const LevelCard({super.key, required this.levelEntity});

  void _handleOnTapLevelCard(BuildContext context) {
    context.go('/home/${levelEntity.id}');
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleOnTapLevelCard(context),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.kD0B8A8,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            levelEntity.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: AppColors.black.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}
