import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/lesson_entity.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_lesson/create_lesson_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_lesson/create_lesson_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_lesson/delete_lesson_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_lesson/delete_lesson_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_jlpt/edit_jlpt_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_lesson/edit_lesson_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_lesson/edit_lesson_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/lesson_manager/lesson_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/lesson_manager/lesson_manager_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/filter_select_box.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/lesson/create_lesson_form.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/lesson/delete_lesson_form.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/lesson/edit_lesson_form.dart';

class LessonManager extends StatefulWidget {
  const LessonManager({super.key});

  @override
  State<LessonManager> createState() => _LessonManagerState();
}

class _LessonManagerState extends State<LessonManager> {
  late LessonManagerCubit _lessonManagerCubit;

  @override
  void initState() {
    _lessonManagerCubit = context.read<LessonManagerCubit>()..init();
    super.initState();
  }

  void _handleShowCreateNewLessonForm() {
    showDialog(
      context: context,
      builder: (context) => LayoutBuilder(
        builder: (context, constraints) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!ResponsiveUtil.isDesktop(context)) {
              context.pop();
            }
          });
          return Dialog(
            child: BlocProvider<CreateLessonCubit>(
              create: (context) => getIt<CreateLessonCubit>()
                ..init(
                  levelId: (_lessonManagerCubit.state as LessonManagerLoaded)
                      .selectedLevelId,
                ),
              child: BlocListener<CreateLessonCubit, CreateLessonState>(
                listener: (context, state) {
                  if (state is CreateLessonSuccess) {
                    _lessonManagerCubit.addLessonListView(lesson: state.lesson);
                  }
                  if (state is CreateLessonFailure ||
                      state is CreateLessonSuccess) {
                    context.pop();
                  }
                },
                child: CreateLessonForm(),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleShowEditLessonForm({required LessonEntity lesson}) async {
    final isShowDeleteForm = await showDialog(
      context: context,
      builder: (context) => LayoutBuilder(
        builder: (context, constraints) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!ResponsiveUtil.isDesktop(context)) {
              context.pop();
            }
          });
          return Dialog(
            child: BlocProvider<EditLessonCubit>(
              create: (context) => getIt<EditLessonCubit>()
                ..init(
                  id: lesson.id,
                  lesson: lesson.lesson,
                ),
              child: BlocListener<EditLessonCubit, EditLessonState>(
                listener: (context, state) {
                  if (state is EditLessonSuccess) {
                    _lessonManagerCubit.updateLessonListView(
                        lesson: state.lesson);
                  }
                  if (state is EditLessonSuccess || state is EditJlptFailure) {
                    context.pop();
                  }
                },
                child: EditLessonForm(
                  lesson: lesson,
                ),
              ),
            ),
          );
        },
      ),
    );
    if (mounted && isShowDeleteForm == true) {
      showDialog(
        context: context,
        builder: (context) => LayoutBuilder(
          builder: (context, constraints) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!ResponsiveUtil.isDesktop(context)) {
                context.pop();
              }
            });
            return Dialog(
              child: BlocProvider<DeleteLessonCubit>(
                create: (context) => getIt<DeleteLessonCubit>()..init(),
                child: BlocListener<DeleteLessonCubit, DeleteLessonState>(
                  listener: (context, state) {
                    if (state is DeleteLessonSuccess) {
                      _lessonManagerCubit.removeLessonListView(
                        lessonId: state.lessonId,
                      );
                    }
                    if (state is DeleteLessonSuccess ||
                        state is DeleteLessonFailure) {
                      context.pop();
                    }
                  },
                  child: DeleteLessonForm(lesson: lesson),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  Widget _actionButton(
      {required String text, required void Function() onPressed}) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 18,
          ),
        ),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        overlayColor: WidgetStatePropertyAll(AppColors.white.withOpacity(0.08)),
        backgroundColor: const WidgetStatePropertyAll(AppColors.kD0B8A8),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: AppColors.black.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _filterJlptSelector() {
    return BlocBuilder<LessonManagerCubit, LessonManagerState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: FilterSelectBox(
                hint: "JLPT",
                items: state is LessonManagerLoaded
                    ? state.levels
                        .map(
                          (level) => {
                            'value': level.id,
                            'label': level.level,
                          },
                        )
                        .toList()
                    : [],
                onChanged: (value) {
                  context
                      .read<LessonManagerCubit>()
                      .updateFilterChoice(levelId: value);
                },
              ),
            ),
            if (state is LessonManagerLoaded && state.selectedLevelId != 'null')
              SizedBox(width: 16),
            if (state is LessonManagerLoaded && state.selectedLevelId != 'null')
              _actionButton(
                text: 'Tạo mới',
                onPressed: _handleShowCreateNewLessonForm,
              ),
          ],
        );
      },
    );
  }

  Widget _lessonTableHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.kDFD3C3,
        border: Border(
          bottom: BorderSide(color: AppColors.black),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.kDFD3C3,
                  border: Border(right: BorderSide(color: AppColors.black)),
                ),
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'STT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.kDFD3C3,
                  border: Border(right: BorderSide(color: AppColors.black)),
                ),
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'Bài học',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.kDFD3C3,
                ),
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'Thao tác',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tableRow({
    required int index,
    required LessonEntity lesson,
    required int length,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.black),
                  right: BorderSide(color: AppColors.black),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                "${index + 1}",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.black),
                  right: BorderSide(color: AppColors.black),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                lesson.lesson,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.black),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: lesson.lesson == "Kanji" ||
                        lesson.lesson == "Hiragana & Katakana"
                    ? SizedBox()
                    : ElevatedButton(
                        style: ButtonStyle(
                          elevation: const WidgetStatePropertyAll(0),
                          padding:
                              const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                          ),
                          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: AppColors.kF8EDE3.withOpacity(0.8)),
                            ),
                          ),
                          overlayColor: WidgetStatePropertyAll(
                              AppColors.black.withOpacity(0.04)),
                          backgroundColor: WidgetStatePropertyAll(
                              AppColors.kF8EDE3.withOpacity(0.8)),
                        ),
                        onPressed: () =>
                            _handleShowEditLessonForm(lesson: lesson),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Sửa',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.black.withOpacity(0.4),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataTable() {
    return BlocBuilder<LessonManagerCubit, LessonManagerState>(
      buildWhen: (previous, current) => current is LessonManagerLoaded,
      builder: (context, state) {
        if (state is LessonManagerLoaded) {
          if (state.selectedLevelId == 'null') {
            return SizedBox();
          }
          return Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(
                  bottom: BorderSide(color: AppColors.black),
                  right: BorderSide(color: AppColors.black),
                  left: BorderSide(color: AppColors.black),
                  top: BorderSide(color: AppColors.black),
                ),
              ),
              child: Column(
                children: [
                  _lessonTableHeader(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.lessons.length,
                      itemBuilder: (context, index) {
                        return _tableRow(
                          index: index,
                          lesson: state.lessons[index],
                          length: state.lessons.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: state is LessonManagerFailure
                    ? Text(
                        state.message,
                        style: TextStyle(
                          color: AppColors.white.withOpacity(0.4),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        children: [
          _filterJlptSelector(),
          SizedBox(height: 16),
          _dataTable(),
        ],
      ),
    );
  }
}
