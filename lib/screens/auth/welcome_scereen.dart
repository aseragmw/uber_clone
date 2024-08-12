import 'package:flutter/material.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: context.screenHeight * 0.04,
            ),
            Image.asset('assets/welcome_screen_vector.png'),
            const SpacingSizedBox(height: true, width: false),
            const SpacingSizedBox(height: true, width: false),
            Text(
              'Tawseela',
              style: TextStyle(
                  fontSize: AppTheme.fontSize20(context),
                  fontWeight: AppTheme.fontWeight600,
                  color: AppTheme.yellowColor),
            ),
            Text(
              'Get a better riding experience',
              style: TextStyle(
                  fontSize: AppTheme.fontSize10(context),
                  fontWeight: AppTheme.fontWeight400),
            ),
          ],
        ),
        SizedBox(
          height: context.screenHeight * 0.15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
                title: 'Create an account',
                onPress: () {
                  Navigator.of(context).pushNamed('registerScreen');
                },
                buttonColor: AppTheme.yellowColor,
                borderRadius: AppTheme.boxRadius,
                borderColor: null,
                buttonWidth: context.screenWidth * 0.8,
                buttonHeight: context.screenHeight * 0.08,
                fontSize: AppTheme.fontSize10(context)),
            const SpacingSizedBox(height: true, width: false),
            CustomButton(
                title: 'Login',
                onPress: () {
                  Navigator.of(context).pushNamed('loginScreen');
                },
                buttonColor: AppTheme.transparentColor,
                borderRadius: AppTheme.boxRadius,
                borderColor: AppTheme.yellowColor,
                buttonWidth: context.screenWidth * 0.8,
                fontColor: AppTheme.yellowColor,
                buttonHeight: context.screenHeight * 0.08,
                fontSize: AppTheme.fontSize10(context)),
          ],
        )
      ],
    ));
  }
}
