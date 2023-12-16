import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class AddComplainScreen extends StatelessWidget {
  AddComplainScreen({super.key});
  final _complainController = TextEditingController();

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
              maxLines: 10,
              hintText: 'Please write your complain',
              trailingIcon: null,
              obsecured: false,
              controller: _complainController,
              filled: false,
              inputType: TextInputType.text),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomButton(
            title: 'Submit',
            onPress: () async {
              final result = await FirestoreDatabase.addComplain(
                  _complainController.text, BasicAuthProvider.currentCustome().uid);
              if (result) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Complain Submitted")));
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Error Occured")));
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
        ],
      ),
    );
  }
}
