import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_kanji/delete_kanji_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_kanji/delete_kanji_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/kanji_manager_button.dart';

class DeleteKanjiForm extends StatelessWidget {
  const DeleteKanjiForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.kF8EDE3,
      ),
      child: BlocBuilder<DeleteKanjiCubit, DeleteKanjiState>(
        buildWhen: (previous, current) =>
            current is DeleteKanjiLoaded || current is DeleteKanjiLoading,
        builder: (context, state) {
          String kanji = '';
          String viet = '';
          String id = 'null';
          if (state is DeleteKanjiLoaded) {
            kanji = state.kanji;
            viet = state.viet;
            id = state.id;
          }
          if (kanji.isEmpty) {
            kanji = "EMPTY VALUE";
          }
          if (viet.isEmpty) {
            viet = "EMPTY";
          }
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.center,
                              'Bạn có chắc chắn muốn xoá Kanji này?',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black.withOpacity(0.4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: state is DeleteKanjiLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.kDFD3C3,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  viet,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black.withOpacity(0.4),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: Text(
                                    kanji,
                                    style: TextStyle(
                                      fontSize: 64,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: KanjiManagerButton(
                          text: 'Xác nhận',
                          onPressed: () => context
                              .read<DeleteKanjiCubit>()
                              .deleteKanji(kanjiId: id),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: KanjiManagerButton(
                          text: 'Huỷ bỏ',
                          onPressed: () => context.pop(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
