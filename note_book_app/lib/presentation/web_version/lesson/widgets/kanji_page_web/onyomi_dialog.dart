import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/onyomi_dialog_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/onyomi_dialog_state.dart';
import 'package:note_book_app/presentation/web_version/lesson/widgets/kanji_page_web/close_dialog_button.dart';

class OnyomiDialog extends StatelessWidget {
  final KanjiEntity kanji;
  final OnyomiDialogCubit onyomiDialogCubit;

  const OnyomiDialog({
    super.key,
    required this.kanji,
    required this.onyomiDialogCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocProvider.value(
        value: onyomiDialogCubit..getAllOnyomisByKanjiId(kanjiId: kanji.id),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.kF8EDE3,
          ),
          width: 600,
          height: 600,
          child: Column(
            children: [
              BlocBuilder<OnyomiDialogCubit, OnyomiDialogState>(
                builder: (context, state) {
                  if (state is OnyomiDialogLoading) {
                    return const Spacer();
                  }
                  return const SizedBox();
                },
              ),
              BlocBuilder<OnyomiDialogCubit, OnyomiDialogState>(
                builder: (context, state) {
                  if (state is OnyomiDialogLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.k8D493A.withOpacity(0.4),
                      ),
                    );
                  }
                  if (state is OnyomiDialogLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ...state.onyomis.map((onSample) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${state.onyomis.indexOf(onSample) + 1}. ${onSample.sample}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Cách đọc: ${onSample.transform}\nĐịnh nghĩa: ${onSample.meaning}",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                              ],
                            );
                          }),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CloseDialogButton(
                  onPressed: (context) => context.pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
