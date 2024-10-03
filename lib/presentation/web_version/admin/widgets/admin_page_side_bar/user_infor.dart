import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_side_bar_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_side_bar_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_web_cubit.dart';

class UserInfor extends StatelessWidget {
  const UserInfor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminPageSideBarCubit, AdminPageSideBarState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state is AdminPageSideBarLoaded
                          ? state.user.fullName
                          : "Loading ...",
                      style: TextStyle(
                        color: AppColors.black.withOpacity(0.8),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      state is AdminPageSideBarLoaded
                          ? state.user.email
                          : "Loading ...",
                      style: TextStyle(
                        color: AppColors.black.withOpacity(0.4),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed: () => context.read<AdminPageWebCubit>().logout(),
                    icon: Icon(
                      Icons.logout,
                      color: AppColors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
