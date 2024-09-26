import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
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
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColors.k8D493A.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is OnyomiDialogLoaded) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...state.onyomis.map((onSample) {
                              return Container(
                                padding: EdgeInsets.only(
                                  top: state.onyomis.indexOf(onSample) == 0
                                      ? 16
                                      : 0,
                                  left: 16,
                                  right: 16,
                                  bottom: state.onyomis.indexOf(onSample) ==
                                          state.onyomis.length - 1
                                      ? 16
                                      : 0,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${state.onyomis.indexOf(onSample) + 1}. ${onSample.sample}",
                                            style: TextStyle(
                                              fontSize:
                                                  ResponsiveUtil.isDesktop(
                                                          context)
                                                      ? 20
                                                      : ResponsiveUtil.isTablet(
                                                              context)
                                                          ? 16
                                                          : 14,
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
                                            style: TextStyle(
                                              fontSize:
                                                  ResponsiveUtil.isDesktop(
                                                          context)
                                                      ? 20
                                                      : ResponsiveUtil.isTablet(
                                                              context)
                                                          ? 16
                                                          : 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              Container(
                padding: const EdgeInsets.all(16),
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
