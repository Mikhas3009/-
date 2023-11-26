import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:flutter/material.dart';

class GeneralPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final String? helperText;
  final String? error;
  final int? maxlength;
  final Function(String)? validator;

  const GeneralPasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.helperText,
    this.error,
    this.maxlength,
    this.validator,
  });

  @override
  PasswordTextFieldState createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<GeneralPasswordField> {
  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.darkColor,
      controller: widget.controller,
      style: TextStyles.inputTextStyle,
      maxLength: widget.maxlength,
      obscureText: visibility,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyles.inputLabelTextStyle,
        hintText: widget.hintText,
        hintStyle: TextStyles.inputHintTextStyle,
        helperText: widget.helperText,
        helperStyle: TextStyles.inputHelperTextStyle,
        errorText: widget.validator != null
            ? widget.validator!(widget.controller.text)
            : null,
        errorStyle: TextStyles.inputErrorTextStyle,
        suffixIcon: InkWell(
          child: Icon(visibility ? Icons.visibility : Icons.visibility_off),
          onTap: () {
            setState(() {
              visibility = !visibility;
            });
          },
        ),
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
