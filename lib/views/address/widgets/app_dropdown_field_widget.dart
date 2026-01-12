import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_textstyles.dart';

class AppDropdownField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:  AppTextStyles.sf14kBlackW400TextStyle,
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: AppTextStyles.sf14kBlackW400TextStyle,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.sf14kGreyW400TextStyle,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kGrey1, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
              enabledBorder:OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.kGrey1, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.kGrey1, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.kGrey1, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.kGrey1, width: 1),
                borderRadius: BorderRadius.circular(8),
              )
          ),
        ),
      ],
    );
  }
}