import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

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
          SizedBox(
            height: context.screenHeight * 0.02,
          ),
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
                final result = await BasicAuthProvider.updateUserPassword(
                    _passwordController.text);
                if (result) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password changed")));

                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Error Occured changing password")));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("Password and confirm password should match")));
              }
            },
            buttonColor: AppTheme.redColor,
            borderRadius: AppTheme.boxRadius,
            borderColor: AppTheme.blackColor,
            buttonWidth: context.screenWidth * 0.7,
            buttonHeight: context.screenHeight * 0.08,
            fontSize: AppTheme.fontSize12(context),
          ),
        ],
      ),
    );
  }
}
