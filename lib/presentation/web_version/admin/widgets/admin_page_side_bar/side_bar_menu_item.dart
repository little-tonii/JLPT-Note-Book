import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_side_bar/admin_page_side_bar_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_side_bar/admin_page_side_bar_state.dart';

class SideBarMenuItem extends StatefulWidget {
  final int index;
  final String title;

  const SideBarMenuItem({super.key, required this.index, required this.title});

  @override
  State<SideBarMenuItem> createState() => _SideBarMenuItemState();
}

class _SideBarMenuItemState extends State<SideBarMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminPageSideBarCubit, AdminPageSideBarState>(
      builder: (context, state) {
        final isSelected = state is AdminPageSideBarLoaded &&
            state.selectedIndex == widget.index;

        return MouseRegion(
          onEnter: (event) => setState(() => _isHovered = true),
          onExit: (event) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: () => context
                .read<AdminPageSideBarCubit>()
                .selectMenuItem(widget.index),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSelected || _isHovered
                    ? AppColors.white.withOpacity(0.8)
                    : Colors.transparent,
              ),
              child: Text(
                widget.title,
                style: TextStyle(
                  color: AppColors.black.withOpacity(0.6),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
