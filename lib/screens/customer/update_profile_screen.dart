import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});
  final _emailController = TextEditingController()
    ..text = BasicAuthProvider.currentCustome().email!;
  final _nameController = TextEditingController()
    ..text = BasicAuthProvider.currentCustome().displayName!;

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
              hintText: 'Your Name',
              trailingIcon: null,
              obsecured: false,
              controller: _nameController,
              filled: false,
              inputType: TextInputType.text),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomTextField(
              hintText: 'Your Email Address',
              trailingIcon: null,
              obsecured: false,
              controller: _emailController,
              filled: false,
              inputType: TextInputType.emailAddress),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomButton(
            title: 'Save Changes',
            onPress: () async {
              if (_emailController.text !=
                  BasicAuthProvider.currentCustome().email) {
                final result = await BasicAuthProvider.updateUserEmail(
                    _emailController.text);
                if (result) {
                  await FirebaseFirestore.instance
                      .collection("customers")
                      .where('customer_id',
                          isEqualTo: BasicAuthProvider.currentCustome().uid)
                      .get()
                      .then((value) async {
                    FirebaseFirestore.instance
                        .collection('customers')
                        .doc(value.docs.first.id)
                        .update({'email': _emailController.text});
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Email changed")));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error Occured changing email")));
                }
              }

              if (_nameController.text !=
                  BasicAuthProvider.currentCustome().displayName) {
                final result = await BasicAuthProvider.updateUserDisplayName(
                    _nameController.text);

                if (result) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Name changed")));
                  await FirebaseFirestore.instance
                      .collection("customers")
                      .where('customer_id',
                          isEqualTo: BasicAuthProvider.currentCustome().uid)
                      .get()
                      .then((value) async {
                    FirebaseFirestore.instance
                        .collection('customers')
                        .doc(value.docs.first.id)
                        .update({'name': _nameController.text});
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error Occured changing Name")));
                }
              }
            },
            buttonColor: AppTheme.redColor,
            borderRadius: AppTheme.boxRadius,
            borderColor: AppTheme.blackColor,
            buttonWidth: context.screenWidth * 0.7,
            buttonHeight: context.screenHeight * 0.08,
            fontSize: AppTheme.fontSize12(context),
          ),
          CustomButton(
            title: 'Change Phone Number',
            onPress: () {
              Navigator.of(context).pushNamed('addPhoneNumberScreen');
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
          CustomButton(
            title: 'Change Password',
            onPress: () {
              Navigator.of(context).pushNamed('changePasswordScreen');
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
