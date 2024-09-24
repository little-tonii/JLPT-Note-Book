import 'package:flutter/material.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/kunyomi_dialog_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/cubits/kanji_page_web/onyomi_dialog_cubit.dart';
import 'package:note_book_app/presentation/web_version/lesson/widgets/kanji_page_web/kunyomi_dialog.dart';
import 'package:note_book_app/presentation/web_version/lesson/widgets/kanji_page_web/onyomi_dialog.dart';

class KanjiComponent extends StatelessWidget {
  final KanjiEntity kanji;
  final KunyomiDialogCubit kunyomiDialogCubit;
  final OnyomiDialogCubit onyomiDialogCubit;

  const KanjiComponent({
    super.key,
    required this.kanji,
    required this.kunyomiDialogCubit,
    required this.onyomiDialogCubit,
  });

  void _handleShowKunSample(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return KunyomiDialog(
          kanji: kanji,
          kunyomiDialogCubit: kunyomiDialogCubit,
        );
      },
    );
  }

  void _handleShowOnSample(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return OnyomiDialog(
          kanji: kanji,
          onyomiDialogCubit: onyomiDialogCubit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kF8EDE3,
        border: Border.all(
          color: AppColors.black.withOpacity(0.8),
          width: 1.6,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: AppColors.black.withOpacity(0.8),
                  width: 1.6,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.black.withOpacity(0.8),
                        width: 1.6,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        kanji.viet,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      kanji.kanji,
                      style: const TextStyle(fontSize: 128),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.black.withOpacity(0.8),
                          width: 1.6,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Âm Kun (thuần Nhật): ${kanji.kun}",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _handleShowKunSample(context),
                          icon: Icon(
                            Icons.rocket_launch_rounded,
                            color: AppColors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Âm On (thuần Hán): ${kanji.on}",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _handleShowOnSample(context),
                          color: AppColors.black.withOpacity(0.4),
                          icon: Icon(
                            Icons.rocket_launch_rounded,
                            color: AppColors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
