import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:flutter/material.dart';

class LightButton extends StatelessWidget {
  final String title;
  final bool isDisabled;
  final VoidCallback onPressed;

  const LightButton({
    super.key,
    required this.title,
    required this.isDisabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.greenColor,
          width: 1,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.whiteColor,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: Text(
          title,
          style: TextStyles.lightButtonTextStyle,
        ),
      ),
    );
  }
}
