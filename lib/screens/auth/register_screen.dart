import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

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
            hintText: 'Name',
            trailingIcon: null,
            obsecured: false,
            controller: _nameController,
            filled: false,
            inputType: TextInputType.text,
          ),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomTextField(
              hintText: 'Email',
              trailingIcon: null,
              obsecured: false,
              controller: _emailController,
              filled: false,
              inputType: TextInputType.emailAddress),
          SizedBox(
            height: context.screenHeight / 50,
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
          // CustomTextField(
          //     hintText: 'Phone Number',
          //     trailingIcon: null,
          //     obsecured: false,
          //     controller: _phoneNumberController,
          //     filled: false,
          //     inputType: TextInputType.number),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomButton(
            title: 'Register',
            onPress: () async {
              try {
                await BasicAuthProvider.register(_nameController.text,
                    _emailController.text, _passwordController.text);
                Navigator.of(context).pushNamed('addPhoneNumberScreen');
              } catch (e) {
                log(e.toString());
              }
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
          Text(
            "Do you have an account?",
            style: TextStyle(
              fontSize: context.screenHeight / context.screenWidth * 10,
              color: Color.fromRGBO(9, 77, 61, 1),
            ),
          ),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomButton(
              title: 'Login',
              onPress: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('loginScreen', (route) => false);
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
