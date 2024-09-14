import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/domain/entities/character_entity.dart';
import 'package:note_book_app/presentation/web_version/character/cubits/character_page_web_cubit.dart';
import 'package:note_book_app/presentation/web_version/character/widgets/character_item.dart';

class CharacterTable extends StatelessWidget {
  final List<CharacterEntity> characters;

  const CharacterTable({
    super.key,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
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
      itemCount: characters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ),
      itemBuilder: (context, index) {
        int row = index ~/ 5;
        int col = index % 5;

        bool isTopRow = row == 0;
        bool isBottomRow = row == (characters.length - 1) ~/ 5;
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
            character: characters[index],
            defaultDisplayCharacter:
                context.read<CharacterPageWebCubit>().showHigarana
                    ? 'Hiragana'
                    : 'Katakana',
          ),
        );
      },
    );
  }
}
