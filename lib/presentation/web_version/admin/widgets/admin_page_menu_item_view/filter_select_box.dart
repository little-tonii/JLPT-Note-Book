import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:note_book_app/common/colors/app_colors.dart';

class FilterSelectBox extends StatefulWidget {
  final String hint;
  final List<String> items;
  final Function(String) onChanged;

  const FilterSelectBox({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  State<FilterSelectBox> createState() => _FilterSelectBoxState();
}

class _FilterSelectBoxState extends State<FilterSelectBox> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 48,
          width: 400,
        ),
        onChanged: (value) {
          setState(() {
            _selectedValue = value;
          });
          if (value != null) {
            widget.onChanged(value);
          }
        },
        value: _selectedValue,
        isExpanded: true,
        hint: Text(
          widget.hint,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.black.withOpacity(0.6),
          ),
        ),
        items: widget.items
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
    );
  }
}
