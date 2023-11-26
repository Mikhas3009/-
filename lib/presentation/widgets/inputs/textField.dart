import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:eco_city/utils/helpers/phoneFormatter.dart';
import 'package:flutter/material.dart';

class GeneralTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final String? hintText;
  final String? helperText;
  final String? error;
  final int? maxlength;
  final Function(String)? validator;
  final bool? enabled;

  const GeneralTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.keyboardType,
    this.hintText,
    this.helperText,
    this.error,
    this.maxlength,
    this.validator,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.darkColor,
      controller: controller,
      style: TextStyles.inputTextStyle,
      keyboardType: keyboardType,
      maxLength: maxlength,
      enabled: enabled,
      inputFormatters: [if (keyboardType == TextInputType.phone) maskFormatter],
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyles.inputLabelTextStyle,
        hintText: hintText,
        hintStyle: TextStyles.inputHintTextStyle,
        helperText: helperText,
        helperStyle: TextStyles.inputHelperTextStyle,
        errorText: validator != null ? validator!(controller.text) : null,
        errorStyle: TextStyles.inputErrorTextStyle,
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.inputBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.inputBorderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.inputBorderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.inputBorderColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.inputBorderColor,
          ),
        ),
      ),
    );
  }
}
