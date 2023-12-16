import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.leadingWidget,
      required this.trailingWidget,
      required this.leadingOnTap,
      required this.trailingOnTap,
      required this.centeredTitle,
      this.titleColor});
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final Function()? leadingOnTap;
  final Function()? trailingOnTap;
  final String? centeredTitle;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.screenHeight * 0.02),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leadingWidget != null
              ? InkWell(
                  onTap: leadingOnTap,
                  child: leadingWidget,
                )
              : const SizedBox(),
          centeredTitle != null
              ? Expanded(
                  child: Center(
                    child: Text(
                      centeredTitle!,
                      style: TextStyle(
                          fontWeight: AppTheme.fontWeight600,
                          color: titleColor,
                          fontSize: AppTheme.fontSize12(context)),
                    ),
                  ),
                )
              : const Spacer(),
          trailingWidget != null
              ? InkWell(
                  onTap: trailingOnTap,
                  child: trailingWidget,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
