import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_page_web_state.dart';
import 'package:note_book_app/presentation/web_version/character/widgets/action_button.dart';
import 'package:note_book_app/presentation/web_version/character/widgets/character_item.dart';

class CharacterPageWeb extends StatefulWidget {
  const CharacterPageWeb({super.key});

  @override
  State<CharacterPageWeb> createState() => _CharacterPageWebState();
}

class _CharacterPageWebState extends State<CharacterPageWeb> {
  void _handleShowHiragana(BuildContext context) {
    context.read<CharacterPageWebCubit>().changeCharacterType(type: 'Hiragana');
  }

  void _handleShowKatakana(BuildContext context) {
    context.read<CharacterPageWebCubit>().changeCharacterType(type: 'Katakana');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharacterPageWebCubit>(
      create: (context) => getIt<CharacterPageWebCubit>()..getAllCharacters(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ResponsiveUtil.isDesktop(context)
                    ? 100
                    : ResponsiveUtil.isTablet(context)
                        ? 40
                        : 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    text: 'Hiragana',
                    onPressed: _handleShowHiragana,
                  ),
                  const SizedBox(width: 16),
                  ActionButton(
                    text: 'Katakana',
                    onPressed: _handleShowKatakana,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    text: 'Ghi nhớ',
                    onPressed: (context) {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              BlocConsumer<CharacterPageWebCubit, CharacterPageWebState>(
                listener: (context, state) {
                  if (state is CharacterPageWebError) {}
                },
                builder: (context, state) {
                  if (state is CharacterPageWebLoading) {
                    return const SizedBox(
                      height: 400,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kDFD3C3,
                        ),
                      ),
                    );
                  }
                  if (state is CharacterPageWebLoaded) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtil.isDesktop(context)
                            ? 400
                            : ResponsiveUtil.isTablet(context)
                                ? 100
                                : 20,
                      ),
                      itemCount: state.characters.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemBuilder: (context, index) {
                        int row = index ~/ 5;
                        int col = index % 5;

                        bool isTopRow = row == 0;
                        bool isBottomRow =
                            row == (state.characters.length - 1) ~/ 5;
                        bool isLeftColumn = col == 0;
                        bool isRightColumn = col == 5 - 1;

                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            border: Border(
                              top: BorderSide(
                                color: AppColors.black,
                                width: isTopRow ? 1 : 0,
                              ),
                              bottom: BorderSide(
                                color: AppColors.black,
                                width: isBottomRow ? 1 : 0,
                              ),
                              left: BorderSide(
                                color: AppColors.black,
                                width: isLeftColumn ? 1 : 0,
                              ),
                              right: BorderSide(
                                color: AppColors.black,
                                width: isRightColumn ? 1 : 0,
                              ),
                            ),
                          ),
                          child: CharacterItem(
                            character: state.characters[index],
                            defaultDisplayCharacter: context
                                    .read<CharacterPageWebCubit>()
                                    .showHigarana
                                ? 'Hiragana'
                                : 'Katakana',
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
