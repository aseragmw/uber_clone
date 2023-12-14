import 'package:flutter/material.dart';
import 'package:uber_clone_app/utils/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      required this.onPress,
      required this.buttonColor,
      required this.borderRadius,
      required this.borderColor,
      required this.buttonWidth,
      required this.fontSize,
      this.buttonHeight,
      this.fontColor});
  final String title;
  final Function() onPress;
  final Color? buttonColor;
  final Color? borderColor;

  final BorderRadius? borderRadius;
  final double? buttonWidth;
  final double? buttonHeight;
  final Color? fontColor;

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            color: buttonColor ?? Colors.transparent,
            borderRadius: borderRadius ?? AppTheme.boxRadius,
            border: Border.all(color: borderColor ?? Colors.transparent)),
        width: buttonWidth ?? double.infinity,
        height: buttonHeight ?? double.infinity,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: AppTheme.fontWeight500,
                color: fontColor ?? Colors.white,
                fontSize: fontSize ?? AppTheme.fontSize18(context)),
          ),
        ),
      ),
    );
  }
}
