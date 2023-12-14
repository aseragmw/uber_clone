import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class ConfirmOTPScreen extends StatefulWidget {
  ConfirmOTPScreen({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<ConfirmOTPScreen> createState() => _ConfirmOTPScreenState();
}

class _ConfirmOTPScreenState extends State<ConfirmOTPScreen> {
  final _smsCodeController = TextEditingController();
  late final String? otp;

  @override
  void initState() {
    super.initState();
    asyncFun();
  }

  Future<void> asyncFun() async {
    final t = await BasicAuthProvider.verifyPhoneNumber(widget.phoneNumber);

    
  }

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
              hintText: 'OTP',
              trailingIcon: null,
              obsecured: false,
              controller: _smsCodeController,
              filled: false,
              inputType: TextInputType.number),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomButton(
            title: 'Confirm',
            onPress: () async {
              final sucess = await BasicAuthProvider.confirmOTP(
                  _smsCodeController.text);
              if (sucess == true) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Right Otp')));
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Wrong Otp')));
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
