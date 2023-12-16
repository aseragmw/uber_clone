import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_app_bar.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAppBar(
              leadingWidget: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_ios_new_rounded),
                  SpacingSizedBox(height: false, width: true),
                  SpacingSizedBox(height: false, width: true),
                  Text(
                    'Back',
                    style: TextStyle(fontSize: AppTheme.fontSize8(context)),
                  ),
                ],
              ),
              trailingWidget: null,
              leadingOnTap: () {
                Navigator.of(context).pop();
              },
              trailingOnTap: null,
              centeredTitle: null),
          SizedBox(
            height: context.screenHeight * 0.05,
          ),
          SizedBox(
            width: context.screenWidth,
            child: Text(
              'Change Password',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: AppTheme.fontSize14(context),
                  fontWeight: AppTheme.fontWeight500),
            ),
          ),
          SpacingSizedBox(height: true, width: false),
          SpacingSizedBox(height: true, width: false),
          SpacingSizedBox(height: true, width: false),
          SpacingSizedBox(height: true, width: false),
          CustomTextField(
              hintText: 'Password',
              trailingIcon: null,
              obsecured: true,
              controller: _passwordController,
              filled: false,
              inputType: TextInputType.text),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomTextField(
              hintText: 'Confirm Password',
              trailingIcon: null,
              obsecured: true,
              controller: _confirmPasswordController,
              filled: false,
              inputType: TextInputType.emailAddress),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomButton(
            title: 'Save Changes',
            onPress: () async {
              if (_passwordController.text == _confirmPasswordController.text) {
                final result = await BasicAuthProvider.getInstance().updateUserPassword(
                    _passwordController.text);
                if (result) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password changed")));

                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Error Occured changing password, Please Logout and try again")));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("Password and confirm password should match")));
              }
            },
            buttonColor: AppTheme.yellowColor,
            borderRadius: AppTheme.boxRadius,
            borderColor: null,
            buttonWidth: context.screenWidth * 0.8,
            buttonHeight: context.screenHeight * 0.08,
            fontSize: AppTheme.fontSize10(context),
          ),
        ],
      ),
    );
  }
}
