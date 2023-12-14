import 'package:flutter/material.dart';
import 'package:uber_clone_app/screens/auth/confirm_otp_screen.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class AddPhoneNumberScreen extends StatelessWidget {
  AddPhoneNumberScreen({super.key});
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
              hintText: 'Phone Number',
              trailingIcon: null,
              obsecured: false,
              controller: _phoneNumberController,
              filled: false,
              inputType: TextInputType.phone),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomButton(
            title: 'Send OTP',
            onPress: () async {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ConfirmOTPScreen(phoneNumber: _phoneNumberController.text)));
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
