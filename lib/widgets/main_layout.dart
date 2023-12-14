import 'package:flutter/material.dart';
import 'package:uber_clone_app/utils/screen_size.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.body});
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
      Focus.of(context).unfocus();
    },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.screenWidth / 40,
                vertical: context.screenHeight * 0.05),
            child: body,
          ),
        ),
      ),
    );
  }
}
