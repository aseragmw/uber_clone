import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_app_bar.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

class ConfirmOTPScreen extends StatefulWidget {
  const ConfirmOTPScreen({super.key, required this.phoneNumber});
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
    await BasicAuthProvider.getInstance().verifyPhoneNumber(widget.phoneNumber);
  }

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
              'Write the OTP sent to your phone number',
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
              hintText: 'OTP',
              trailingIcon: null,
              obsecured: false,
              controller: _smsCodeController,
              filled: false,
              inputType: TextInputType.number),
          const SpacingSizedBox(height: true, width: false),
          const SpacingSizedBox(height: true, width: false),
          const SpacingSizedBox(height: true, width: false),
          CustomButton(
            title: 'Confirm',
            onPress: () async {
              final sucess = await BasicAuthProvider.getInstance()
                  .confirmOTP(_smsCodeController.text);
              if (sucess == true) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'customerHomeScreen', (route) => false);
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Wrong Otp')));
              }
            },
            buttonColor: AppTheme.yellowColor,
            borderRadius: AppTheme.boxRadius,
            borderColor: null,
            buttonWidth: context.screenWidth * 0.8,
            buttonHeight: context.screenHeight * 0.08,
            fontSize: AppTheme.fontSize12(context),
          ),
        ],
      ),
    );
  }
}
