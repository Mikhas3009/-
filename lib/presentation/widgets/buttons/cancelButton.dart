import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final String title;
  final bool isDisabled;
  final VoidCallback onPressed;

  CancelButton({
    super.key,
    required this.title,
    required this.isDisabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDisabled ? null : AppColors.redColor),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: Text(
          title,
          style: TextStyles.generalButtonTextStyle,
        ),
      ),
    );
  }
}
