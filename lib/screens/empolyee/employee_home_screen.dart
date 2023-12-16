import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class EmployeeHomeScreen extends StatelessWidget {
  EmployeeHomeScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.screenHeight * 0.02,
          ),
          CustomButton(
            title: 'Add A Driver',
            onPress: () {
              Navigator.of(context).pushNamed('addDriverScreen');
            },
            buttonColor: AppTheme.redColor,
            borderRadius: AppTheme.boxRadius,
            borderColor: AppTheme.blackColor,
            buttonWidth: context.screenWidth * 0.7,
            buttonHeight: context.screenHeight * 0.08,
            fontSize: AppTheme.fontSize12(context),
          ),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomButton(
              title: 'Add A Car',
              onPress: () {
                Navigator.of(context).pushNamed(
                  'addCarScreen',
                );
              },
              buttonColor: AppTheme.redColor,
              borderRadius: AppTheme.boxRadius,
              borderColor: AppTheme.blackColor,
              buttonWidth: context.screenWidth * 0.7,
              buttonHeight: context.screenHeight * 0.08,
              fontSize: AppTheme.fontSize12(context)),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomButton(
              title: 'View Complaints',
              onPress: () {
                Navigator.of(context).pushNamed(
                  'viewComplaintsScreen',
                );
              },
              buttonColor: AppTheme.redColor,
              borderRadius: AppTheme.boxRadius,
              borderColor: AppTheme.blackColor,
              buttonWidth: context.screenWidth * 0.7,
              buttonHeight: context.screenHeight * 0.08,
              fontSize: AppTheme.fontSize12(context)),
        ],
      ),
    );
  }
}
