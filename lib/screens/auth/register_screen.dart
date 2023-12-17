import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_app_bar.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
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
            height: context.screenHeight * 0.05,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: context.screenWidth,
                child: Text(
                  'Register',
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
                hintText: 'Name',
                trailingIcon: null,
                obsecured: false,
                controller: _nameController,
                filled: false,
                inputType: TextInputType.text,
              ),
              const SpacingSizedBox(height: true, width: false),
              const SpacingSizedBox(height: true, width: false),
              const SpacingSizedBox(height: true, width: false),
              CustomTextField(
                  hintText: 'Email',
                  trailingIcon: null,
                  obsecured: false,
                  controller: _emailController,
                  filled: false,
                  inputType: TextInputType.emailAddress),
              const SpacingSizedBox(height: true, width: false),
              const SpacingSizedBox(height: true, width: false),
              const SpacingSizedBox(height: true, width: false),
              CustomTextField(
                  hintText: 'Password',
                  trailingIcon: null,
                  obsecured: true,
                  controller: _passwordController,
                  filled: false,
                  inputType: TextInputType.text),
              const SpacingSizedBox(height: true, width: false),
              const SpacingSizedBox(height: true, width: false),
              const SpacingSizedBox(height: true, width: false),
              CustomTextField(
                  hintText: 'Confirm Password',
                  trailingIcon: null,
                  obsecured: true,
                  controller: _confirmPasswordController,
                  filled: false,
                  inputType: TextInputType.text),
              const SpacingSizedBox(height: true, width: false),
              const SpacingSizedBox(height: true, width: false),
              const SpacingSizedBox(height: true, width: false),
              const SpacingSizedBox(height: true, width: false),
              const SpacingSizedBox(height: true, width: false),
              CustomButton(
                title: 'Register',
                onPress: () async {
                  if (_passwordController.text ==
                      _confirmPasswordController.text) {
                    final result = await BasicAuthProvider.getInstance().register(
                        _nameController.text,
                        _emailController.text,
                        _passwordController.text);
                    if (result) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Center(
                          child: Text('Regsitered Successfully'),
                        ),
                      ));
                      Navigator.of(context).pushNamed('addPhoneNumberScreen');
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Center(
                        child: Text('Regsiter Failed'),
                      ),
                    ));
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
        ],
      ),
    );
  }
}



