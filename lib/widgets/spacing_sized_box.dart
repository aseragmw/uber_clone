import 'package:flutter/material.dart';
import 'package:uber_clone_app/utils/screen_size.dart';

class SpacingSizedBox extends StatelessWidget {
  const SpacingSizedBox({super.key, required this.height, required this.width});
  final bool height;
  final bool width;

  @override
  Widget build(BuildContext context) {
    if (height) {
      return SizedBox(
        height: context.screenHeight * 0.01,
      );
    } else {
      return SizedBox(
        width: context.screenWidth * 0.005,
      );
    }
  }
}
