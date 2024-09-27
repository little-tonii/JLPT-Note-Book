import 'package:flutter/material.dart';
import 'package:note_book_app/common/colors/app_colors.dart';
import 'package:note_book_app/common/utils/responsive_util.dart';
import 'package:note_book_app/domain/entities/character_entity.dart';

class CharacterItem extends StatefulWidget {
  final String defaultDisplayCharacter;
  final CharacterEntity character;

  const CharacterItem({
    super.key,
    required this.character,
    required this.defaultDisplayCharacter,
  });

  @override
  State<CharacterItem> createState() => _CharacterItemState();
}

class _CharacterItemState extends State<CharacterItem> {
  String _displayText = '';
  String _defaultDisplayText = '';
  bool _isShowRomanji = false;

  @override
  void initState() {
    setState(() {
      _defaultDisplayText = widget.defaultDisplayCharacter;
      _displayText = _defaultDisplayText == 'Hiragana'
          ? widget.character.hiragana
          : widget.character.katakana;
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CharacterItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.defaultDisplayCharacter != widget.defaultDisplayCharacter) {
      _defaultDisplayText = widget.defaultDisplayCharacter;
      _displayText = _defaultDisplayText == 'Hiragana'
          ? widget.character.hiragana
          : widget.character.katakana;
      _isShowRomanji = false;
    }
  }

  void _handleShowRomanji() {
    setState(() {
      _isShowRomanji = !_isShowRomanji;
      _displayText = _isShowRomanji
          ? widget.character.romanji
          : _defaultDisplayText == 'Hiragana'
              ? widget.character.hiragana
              : widget.character.katakana;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleShowRomanji,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.black,
            width: 1,
          ),
          color: AppColors.white,
        ),
        child: Center(
          child: Text(
            _displayText,
            style: TextStyle(
              color: AppColors.black.withOpacity(0.8),
              fontSize: ResponsiveUtil.isDesktop(context)
                  ? 40
                  : ResponsiveUtil.isTablet(context)
                      ? 32
                      : 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
