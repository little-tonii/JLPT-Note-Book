import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/domain/entities/kanji_entity.dart';
import 'package:note_book_app/presentation/web_version/lesson/widgets/kanji_page_web/close_dialog_button.dart';

class KanjiComponent extends StatelessWidget {
  final KanjiEntity kanji;

  const KanjiComponent({super.key, required this.kanji});

  void _handleCloseDialog(BuildContext context) {
    context.pop();
  }

  void _handleShowKunSample(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ...kanji.kunEntities.map((onSample) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${kanji.kunEntities.indexOf(onSample) + 1}. ${onSample.sample}",
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
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: CloseDialogButton(
                    onPressed: _handleCloseDialog,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleShowOnSample(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ...kanji.onEntities.map((onSample) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${kanji.onEntities.indexOf(onSample) + 1}. ${onSample.sample}",
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
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: CloseDialogButton(
                    onPressed: _handleCloseDialog,
                  ),
                ),
              ],
            ),
          ),
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
                        kanji.kunEntities.isNotEmpty
                            ? IconButton(
                                onPressed: () => _handleShowKunSample(context),
                                icon: Icon(
                                  Icons.rocket_launch_rounded,
                                  color: AppColors.black.withOpacity(0.6),
                                ),
                              )
                            : const SizedBox(),
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
                        kanji.onEntities.isNotEmpty
                            ? IconButton(
                                onPressed: () => _handleShowOnSample(context),
                                color: AppColors.black.withOpacity(0.4),
                                icon: Icon(
                                  Icons.rocket_launch_rounded,
                                  color: AppColors.black.withOpacity(0.6),
                                ),
                              )
                            : const SizedBox(),
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
