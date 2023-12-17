import 'package:flutter/material.dart';
import 'package:uber_clone_app/utils/screen_size.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.body, this.bottomNavBar});
  final Widget body;
  final Widget? bottomNavBar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomNavBar,
        body: SelectionArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth / 40,
                  vertical: context.screenHeight * 0.05),
              child: Center(child: body),
            ),
          ),
        ),
      ),
    );
  }
}
