import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_side_bar/admin_page_side_bar_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_side_bar/side_bar_menu_item.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_side_bar/user_infor.dart';

class AdminPageSideBar extends StatelessWidget {
  const AdminPageSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AdminPageSideBarCubit>().getUserInfor();
    return Container(
      width: 360,
      decoration: const BoxDecoration(
        color: AppColors.kDFD3C3,
      ),
      child: Column(
        children: [
          const UserInfor(),
          ...["JNPT", "Bài học", "Hán tự", "Từ vựng", "Logs"]
              .asMap()
              .entries
              .map((entry) {
            final index = entry.key;
            final title = entry.value;
            return SideBarMenuItem(
              index: index,
              title: title,
            );
          }),
        ],
      ),
    );
  }
}
