import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

class AddComplainScreen extends StatelessWidget {
  AddComplainScreen({super.key});
  final _complainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomTextField(
            maxLines: 10,
            hintText: 'Please write your complain',
            trailingIcon: null,
            obsecured: false,
            controller: _complainController,
            filled: false,
            inputType: TextInputType.text),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomButton(
          title: 'Submit',
          onPress: () async {
            final result = await FirestoreDatabase.getInstance().addComplain(
                _complainController.text,
                BasicAuthProvider.getInstance().currentCustomer().uid);
            if (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Complain Submitted")));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Error Occured")));
            }
          },
          buttonColor: AppTheme.yellowColor,
          borderRadius: AppTheme.boxRadius,
          borderColor: null,
          buttonWidth: context.screenWidth * 0.8,
          buttonHeight: context.screenHeight * 0.08,
          fontSize: AppTheme.fontSize10(context),
        ),
        SizedBox(
          height: context.screenHeight / 50,
        ),
      ],
    );
  }
}
