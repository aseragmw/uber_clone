import 'package:flutter/material.dart';
import 'package:uber_clone_app/utils/app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.trailingIcon,
    required this.obsecured,
    required this.controller,
    required this.filled,
    this.fillColor,
    this.inputType,
    this.minLines,
    this.maxLines,
    this.initalValue,
  });
  final String hintText;
  final Widget? trailingIcon;
  final bool? obsecured;
  final bool filled;
  final Color? fillColor;
  final TextEditingController controller;
  final TextInputType? inputType;
  final int? minLines;
  final int? maxLines;
    final String? initalValue;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initalValue,
      controller: controller,
      minLines: minLines,
      maxLines: maxLines ?? 1,
      obscureText: obsecured ?? false,
      keyboardType: inputType,
      decoration: InputDecoration(
          fillColor: fillColor ?? Colors.transparent,
          filled: filled,
          focusedBorder:
              const OutlineInputBorder(borderRadius: AppTheme.boxRadius),
          hintText: hintText,
          suffixIcon: trailingIcon,
          border: const OutlineInputBorder(borderRadius: AppTheme.boxRadius)),
    );
  }
}
