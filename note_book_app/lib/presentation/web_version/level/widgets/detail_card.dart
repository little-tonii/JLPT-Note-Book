import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/domain/entities/level_details_entity.dart';

class DetailCard extends StatelessWidget {
  final LevelDetailsEntity detail;

  const DetailCard({super.key, required this.detail});

  void _handleOnTapDetailCard(BuildContext context) {
    context.go("/home/${detail.level}/${detail.id}");
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
            "${detail.level} | ${detail.name}",
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
