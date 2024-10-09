import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_log_manager/admin_log_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_side_bar/admin_page_side_bar_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_side_bar/admin_page_side_bar_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/jnpt_manager/jnpt_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/kanji_manager/kanji_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/lesson_manager/lesson_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/word_manager/word_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/admin_log_manager.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/jnpt_manager.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/kanji_manager.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/lesson_manager.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/word_manager.dart';

class AdminPageMenuItemView extends StatelessWidget {
  const AdminPageMenuItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AdminPageSideBarCubit, AdminPageSideBarState>(
        builder: (context, state) {
          if (state is AdminPageSideBarLoaded) {
            if (state.selectedIndex == 0) {
              return BlocProvider<JnptManagerCubit>(
                create: (context) => getIt<JnptManagerCubit>(),
                child: const JnptManager(),
              );
            }
            if (state.selectedIndex == 1) {
              return BlocProvider<LessonManagerCubit>(
                create: (context) => getIt<LessonManagerCubit>(),
                child: const LessonManager(),
              );
            }
            if (state.selectedIndex == 2) {
              return BlocProvider<KanjiManagerCubit>(
                create: (context) =>
                    getIt<KanjiManagerCubit>()..updateFilterChoice(),
                child: const KanjiManager(),
              );
            }
            if (state.selectedIndex == 3) {
              return BlocProvider<WordManagerCubit>(
                create: (context) => getIt<WordManagerCubit>(),
                child: const WordManager(),
              );
            }
            if (state.selectedIndex == 4) {
              return BlocProvider<AdminLogManagerCubit>(
                create: (context) => getIt<AdminLogManagerCubit>(),
                child: const AdminLogManager(),
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
