import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/entities/level_entity.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_new_jlpt/create_new_jlpt_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/create_new_jlpt/create_new_jlpt_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_jlpt/delete_jlpt_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/delete_jlpt/delete_jlpt_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_jlpt/edit_jlpt_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_jlpt/edit_jlpt_state.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/jlpt_manager/jlpt_manager_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/jlpt_manager/jlpt_manager_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/create_new_jlpt_form.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/delete_jlpt_form.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/edit_jlpt_form.dart';

class JlptManager extends StatefulWidget {
  const JlptManager({super.key});

  @override
  State<JlptManager> createState() => _JlptManagerState();
}

class _JlptManagerState extends State<JlptManager> {
  late JlptManagerCubit _jlptManagerCubit;

  @override
  void initState() {
    _jlptManagerCubit = context.read<JlptManagerCubit>()..init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleReload() {
    context.read<JlptManagerCubit>().init();
  }

  void _handleShowCreateNewJlptForm() {
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
            child: BlocProvider<CreateNewJlptCubit>(
              create: (context) => getIt<CreateNewJlptCubit>()..init(),
              child: BlocListener<CreateNewJlptCubit, CreateNewJlptState>(
                child: const CreateNewJlptForm(),
                listener: (BuildContext context, CreateNewJlptState state) {
                  if (state is CreateNewJlptSuccess) {
                    _jlptManagerCubit.addJlptListView(jlpt: state.levelEntity);
                  }
                  if (state is CreateNewJlptSuccess ||
                      state is CreateNewJlptFailure) {
                    context.pop();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleShowDeleteJlptForm({required LevelEntity level}) {
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
            child: BlocProvider<DeleteJlptCubit>(
              create: (context) => getIt<DeleteJlptCubit>()..init(),
              child: BlocListener<DeleteJlptCubit, DeleteJlptState>(
                listener: (context, state) {
                  if (state is DeleteJlptSuccess) {
                    _jlptManagerCubit.removeJlptListView(
                      jlptId: state.levelEntity.id,
                    );
                  }
                  if (state is DeleteJlptSuccess ||
                      state is DeleteJlptFailure) {
                    context.pop();
                  }
                },
                child: DeleteJlptForm(jlpt: level),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleShowEditJlptForm({required LevelEntity level}) {
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
            child: BlocProvider<EditJlptCubit>(
              create: (context) => getIt<EditJlptCubit>()..init(),
              child: BlocListener<EditJlptCubit, EditJlptState>(
                listener: (context, state) {
                  if (state is EditJlptSuccess) {
                    _jlptManagerCubit.updateJlptListView(jlpt: state.level);
                  }
                  if (state is EditJlptSuccess || state is EditJlptFailure) {
                    context.pop();
                  }
                },
                child: EditJlptForm(jlpt: level),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _jlptTableHeader() {
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
                  'JLPT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 2,
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

  Widget _actionSelector() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                value: null,
                dropdownStyleData: DropdownStyleData(
                  offset: const Offset(0, -8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    color: AppColors.kDFD3C3,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  height: 48,
                  width: double.infinity,
                ),
                onChanged: (value) {
                  if (value == "Tải lại") {
                    _handleReload();
                  } else if (value == "Tạo mới JLPT") {
                    _handleShowCreateNewJlptForm();
                  }
                },
                isExpanded: true,
                hint: Text(
                  "Hành động",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.black.withOpacity(0.6),
                  ),
                ),
                items: ["Tải lại", "Tạo mới JLPT"]
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const Expanded(
            flex: 4,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow({
    required int index,
    required LevelEntity level,
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
                level.level,
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
                  right: BorderSide(color: AppColors.black),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: const WidgetStatePropertyAll(0),
                    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
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
                  onPressed: () => _handleShowEditJlptForm(level: level),
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
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: const WidgetStatePropertyAll(0),
                    padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
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
                  onPressed: () => _handleShowDeleteJlptForm(level: level),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Xoá',
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        children: [
          _actionSelector(),
          const SizedBox(height: 16),
          BlocBuilder<JlptManagerCubit, JlptManagerState>(
            buildWhen: (previous, current) => current is JlptManagerLoaded,
            builder: (context, state) {
              if (state is JlptManagerLoaded) {
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
                        _jlptTableHeader(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.levels.length,
                            itemBuilder: (context, index) {
                              return _buildTableRow(
                                index: index,
                                level: state.levels[index],
                                length: state.levels.length,
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
                      child: state is JlptManagerFailure
                          ? Text(
                              state.message,
                              style: TextStyle(
                                color: AppColors.white.withOpacity(0.4),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: AppColors.kDFD3C3,
                            ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
