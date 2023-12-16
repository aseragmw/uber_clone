import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});
  final _emailController = TextEditingController()
    ..text = BasicAuthProvider.getInstance().currentCustome().email!;
  final _nameController = TextEditingController()
    ..text = BasicAuthProvider.getInstance().currentCustome().displayName!;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpacingSizedBox(height: true, width: false),
        SpacingSizedBox(height: true, width: false),
        CustomTextField(
            hintText: 'Your Name',
            trailingIcon: null,
            obsecured: false,
            controller: _nameController,
            filled: false,
            inputType: TextInputType.text),
        SpacingSizedBox(height: true, width: false),
        SpacingSizedBox(height: true, width: false),
        CustomTextField(
            hintText: 'Your Email Address',
            trailingIcon: null,
            obsecured: false,
            controller: _emailController,
            filled: false,
            inputType: TextInputType.emailAddress),
        SpacingSizedBox(height: true, width: false),
        SpacingSizedBox(height: true, width: false),
        SpacingSizedBox(height: true, width: false),
        CustomButton(
          title: 'Save Changes',
          onPress: () async {
            if (_emailController.text !=
                BasicAuthProvider.getInstance().currentCustome().email) {
              final result = await BasicAuthProvider.getInstance().updateUserEmail(
                  _emailController.text);
              if (result) {
                await FirebaseFirestore.instance
                    .collection("customers")
                    .where('customer_id',
                        isEqualTo: BasicAuthProvider.getInstance().currentCustome().uid)
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
                BasicAuthProvider.getInstance().currentCustome().displayName) {
              final result = await BasicAuthProvider.getInstance().updateUserDisplayName(
                  _nameController.text);

              if (result) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Name changed")));
                await FirebaseFirestore.instance
                    .collection("customers")
                    .where('customer_id',
                        isEqualTo: BasicAuthProvider.getInstance().currentCustome().uid)
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
          buttonColor: AppTheme.yellowColor,
          borderRadius: AppTheme.boxRadius,
          borderColor: null,
          buttonWidth: context.screenWidth * 0.8,
          buttonHeight: context.screenHeight * 0.08,
          fontSize: AppTheme.fontSize10(context),
        ),
        SpacingSizedBox(height: true, width: false),
        SpacingSizedBox(height: true, width: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: context.screenWidth * 0.4,
              child: Divider(),
            ),
            Text(
              'or',
              style: TextStyle(
                  fontSize: AppTheme.fontSize8(context),
                  fontWeight: AppTheme.fontWeight500),
            ),
            SizedBox(
              width: context.screenWidth * 0.4,
              child: Divider(),
            ),
          ],
        ),
        SpacingSizedBox(height: true, width: false),
        SpacingSizedBox(height: true, width: false),
        CustomButton(
          title: 'Change Phone Number',
          onPress: () {
            Navigator.of(context).pushNamed('addPhoneNumberScreen');
          },
          buttonColor: AppTheme.transparentColor,
          borderRadius: AppTheme.boxRadius,
          borderColor: AppTheme.yellowColor,
          buttonWidth: context.screenWidth * 0.8,
          buttonHeight: context.screenHeight * 0.08,
          fontColor: AppTheme.yellowColor,
          fontSize: AppTheme.fontSize10(context),
        ),
        SpacingSizedBox(height: true, width: false),
        SpacingSizedBox(height: true, width: false),
        CustomButton(
          title: 'Change Password',
          onPress: () {
            Navigator.of(context).pushNamed('changePasswordScreen');
          },
          buttonColor: AppTheme.transparentColor,
          borderRadius: AppTheme.boxRadius,
          borderColor: AppTheme.yellowColor,
          buttonWidth: context.screenWidth * 0.8,
          buttonHeight: context.screenHeight * 0.08,
          fontColor: AppTheme.yellowColor,
          fontSize: AppTheme.fontSize10(context),
        ),
        SpacingSizedBox(height: true, width: false),
        SpacingSizedBox(height: true, width: false),
        CustomButton(
          title: 'Log Out',
          onPress: () async {
            final result = await BasicAuthProvider.getInstance().logout();
            if (result) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('welcomeScreen', (route) => false);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                child: Text('Error Occured'),
              )));
            }
          },
          buttonColor: AppTheme.transparentColor,
          borderRadius: AppTheme.boxRadius,
          borderColor: AppTheme.yellowColor,
          buttonWidth: context.screenWidth * 0.8,
          buttonHeight: context.screenHeight * 0.08,
          fontColor: AppTheme.yellowColor,
          fontSize: AppTheme.fontSize10(context),
        ),
      ],
    );
  }
}
