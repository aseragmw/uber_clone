import 'package:flutter/material.dart';
import 'package:uber_clone_app/screens/auth/confirm_otp_screen.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_app_bar.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

class AddPhoneNumberScreen extends StatelessWidget {
  AddPhoneNumberScreen({super.key});
  final _phoneNumberController = TextEditingController();

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
                  const Icon(Icons.arrow_back_ios_new_rounded),
                  const SpacingSizedBox(height: false, width: true),
                  const SpacingSizedBox(height: false, width: true),
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
            height: context.screenHeight * 0.04,
          ),
          SizedBox(
            width: context.screenWidth,
            child: Text(
              'Add Your Phone Number',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: AppTheme.fontSize14(context),
                  fontWeight: AppTheme.fontWeight500),
            ),
          ),
          const SpacingSizedBox(height: true, width: false),
          const SpacingSizedBox(height: true, width: false),
          const SpacingSizedBox(height: true, width: false),
          const SpacingSizedBox(height: true, width: false),
          CustomTextField(
              hintText: 'Phone Number',
              trailingIcon: null,
              obsecured: false,
              controller: _phoneNumberController,
              filled: false,
              inputType: TextInputType.phone),
          const SpacingSizedBox(height: true, width: false),
          const SpacingSizedBox(height: true, width: false),
          const SpacingSizedBox(height: true, width: false),
          CustomButton(
            title: 'Send OTP',
            onPress: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ConfirmOTPScreen(
                      phoneNumber: _phoneNumberController.text)));
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
