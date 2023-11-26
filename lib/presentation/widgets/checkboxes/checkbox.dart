import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:flutter/material.dart';

class GeneralCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String label;

  const GeneralCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1.25,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            tristate: true,
            activeColor: AppColors.greenColor,
            shape: const CircleBorder(),
            side: const BorderSide(
              width: 1,
              color: AppColors.greenColor,
            ),
          ),
        ),
        Text(
          label,
          style: TextStyles.greyCaptionTextStyle,
        )
      ],
    );
  }
}
