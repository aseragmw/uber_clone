import 'package:flutter/material.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';

class TripHistoryItem extends StatelessWidget {
  const TripHistoryItem({super.key, required this.keyy, required this.value});
  final String keyy;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.screenAspectRatio * 5),
      margin: EdgeInsets.symmetric(vertical: context.screenAspectRatio * 2),
      decoration: const BoxDecoration(
        color: AppTheme.yellowColor,
        borderRadius: AppTheme.boxRadius,
      ),
      width: context.screenWidth * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            keyy,
            style: TextStyle(
                fontSize: AppTheme.fontSize8(context),
                fontWeight: AppTheme.fontWeight400),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: AppTheme.fontSize8(context),
                fontWeight: AppTheme.fontWeight400),
          ),
        ],
      ),
    );
  }
}
