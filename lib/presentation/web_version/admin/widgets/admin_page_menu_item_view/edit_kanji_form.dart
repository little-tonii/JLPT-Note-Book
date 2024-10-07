import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/domain/entities/kunyomi_entity.dart';
import 'package:note_book_app/domain/entities/onyomi_entity.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_kanji/edit_kanji_cubit.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/edit_kanji/edit_kanji_state.dart';
import 'package:note_book_app/presentation/web_version/admin/widgets/admin_page_menu_item_view/kanji_manager_button.dart';

class EditKanjiForm extends StatefulWidget {
  const EditKanjiForm({super.key});

  @override
  State<EditKanjiForm> createState() => _EditKanjiFormState();
}

class _EditKanjiFormState extends State<EditKanjiForm> {
  late TextEditingController _kanjiController;
  late TextEditingController _hanVietController;
  late TextEditingController _kunController;
  late TextEditingController _onController;
  late List<TextEditingController> _exampleKunController;
  late List<TextEditingController> _exampleOnController;
  late List<TextEditingController> _meaningKunController;
  late List<TextEditingController> _meaningOnController;
  late List<TextEditingController> _transformKunController;
  late List<TextEditingController> _transformOnController;

  @override
  void initState() {
    _kanjiController = TextEditingController();
    _hanVietController = TextEditingController();
    _kunController = TextEditingController();
    _onController = TextEditingController();
    _exampleKunController = [];
    _exampleOnController = [];
    _meaningKunController = [];
    _meaningOnController = [];
    _transformKunController = [];
    _transformOnController = [];
    super.initState();
  }

  @override
  void dispose() {
    _kanjiController.dispose();
    _hanVietController.dispose();
    _kunController.dispose();
    _onController.dispose();
    for (var element in _exampleKunController) {
      element.dispose();
    }
    for (var element in _exampleOnController) {
      element.dispose();
    }
    for (var element in _meaningKunController) {
      element.dispose();
    }
    for (var element in _meaningOnController) {
      element.dispose();
    }
    for (var element in _transformKunController) {
      element.dispose();
    }
    for (var element in _transformOnController) {
      element.dispose();
    }
    super.dispose();
  }

  void _handleConfirmSaveKanji() {}

  Widget _dataField({
    required String title,
    required TextEditingController controller,
    required String hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.black.withOpacity(0.4),
                  ),
                ),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.black.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: _yomiField(
                hintText: hintText,
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _yomiField(
      {required String hintText, required TextEditingController controller}) {
    return TextField(
      cursorColor: AppColors.black,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.kDFD3C3,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        hintStyle: TextStyle(
          color: AppColors.black.withOpacity(0.4),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        hintText: hintText,
      ),
    );
  }

  Widget _dialogHandleActionFormButton(
      {required void Function() onPressed, required String text}) {
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
            side: const BorderSide(color: AppColors.kF8EDE3),
          ),
        ),
        overlayColor: WidgetStatePropertyAll(AppColors.black.withOpacity(0.04)),
        backgroundColor: const WidgetStatePropertyAll(AppColors.kF8EDE3),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.black.withOpacity(0.4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 800,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.kF8EDE3,
      ),
      child: BlocBuilder<EditKanjiCubit, EditKanjiState>(
        builder: (context, state) {
          if (state is EditKanjiLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.kDFD3C3,
              ),
            );
          }
          List<KunyomiEntity> kunyomis = [];
          List<OnyomiEntity> onyomis = [];
          if (state is EditKanjiLoaded) {
            kunyomis = state.kunyomis;
            onyomis = state.onyomis;
            _kanjiController.text = state.kanji.kanji;
            _hanVietController.text = state.kanji.viet;
            _kunController.text = state.kanji.kun;
            _onController.text = state.kanji.on;
            for (var i = 0; i < state.kunyomis.length; i++) {
              _exampleKunController.add(
                TextEditingController()..text = state.kunyomis[i].sample,
              );
              _meaningKunController.add(
                TextEditingController()..text = state.kunyomis[i].meaning,
              );
              _transformKunController.add(
                TextEditingController()..text = state.kunyomis[i].transform,
              );
            }
            for (var i = 0; i < state.onyomis.length; i++) {
              _exampleOnController.add(
                TextEditingController()..text = state.onyomis[i].sample,
              );
              _meaningOnController.add(
                TextEditingController()..text = state.onyomis[i].meaning,
              );
              _transformOnController.add(
                TextEditingController()..text = state.onyomis[i].transform,
              );
            }
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _dataField(
                        title: 'Chữ Kanji',
                        controller: _kanjiController,
                        hintText: "Nhập chữ Kanji",
                      ),
                      _dataField(
                        title: 'Âm Hán Việt',
                        controller: _hanVietController,
                        hintText: "Nhập âm Hán Việt",
                      ),
                      _dataField(
                        title: 'Âm Kun',
                        controller: _kunController,
                        hintText: "Nhập âm Kun",
                      ),
                      _dataField(
                        title: 'Âm On',
                        controller: _onController,
                        hintText: "Nhập âm On",
                      ),
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    ...kunyomis.asMap().entries.map((entry) {
                                      final index = entry.key;
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: AppColors.black
                                                  .withOpacity(0.4),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 8),
                                            _yomiField(
                                              hintText: "Nhập Kunyomi Kanji",
                                              controller:
                                                  _exampleKunController[index],
                                            ),
                                            const SizedBox(height: 8),
                                            _yomiField(
                                              hintText: "Nhập Kunyomi Hiragana",
                                              controller:
                                                  _transformKunController[
                                                      index],
                                            ),
                                            const SizedBox(height: 8),
                                            _yomiField(
                                              hintText: "Nhập nghĩa Kunyomi",
                                              controller:
                                                  _meaningKunController[index],
                                            ),
                                            const SizedBox(height: 8),
                                            IntrinsicHeight(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        _dialogHandleActionFormButton(
                                                      onPressed: () {},
                                                      text: 'Huỷ Kunyomi',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      );
                                    }),
                                    const SizedBox(height: 8),
                                    IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child:
                                                _dialogHandleActionFormButton(
                                              onPressed: () {},
                                              text: 'Thêm ví dụ Kunyomi',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    ...onyomis.asMap().entries.map((entry) {
                                      final index = entry.key;
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: AppColors.black
                                                  .withOpacity(0.4),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 8),
                                            _yomiField(
                                              hintText: "Nhập Onyomi Kanji",
                                              controller:
                                                  _exampleOnController[index],
                                            ),
                                            const SizedBox(height: 8),
                                            _yomiField(
                                              hintText: "Nhập Onyomi Hiragana",
                                              controller:
                                                  _transformOnController[index],
                                            ),
                                            const SizedBox(height: 8),
                                            _yomiField(
                                              hintText: "Nhập nghĩa Onyomi",
                                              controller:
                                                  _meaningOnController[index],
                                            ),
                                            const SizedBox(height: 8),
                                            IntrinsicHeight(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        _dialogHandleActionFormButton(
                                                      onPressed: () {},
                                                      text: 'Huỷ Onyomi',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      );
                                    }),
                                    const SizedBox(height: 8),
                                    IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child:
                                                _dialogHandleActionFormButton(
                                              onPressed: () {},
                                              text: 'Thêm ví dụ Onyomi',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: _dialogHandleActionFormButton(
                                  onPressed: () {
                                    context.pop(true);
                                  },
                                  text: 'Xoá Kanji',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          text: 'Lưu thay đổi',
                          onPressed: _handleConfirmSaveKanji,
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
