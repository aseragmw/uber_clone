import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class AddCarScreen extends StatelessWidget {
  AddCarScreen({super.key});
  final _carTypeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _plateNumberController = TextEditingController();

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
              hintText: 'Car Type',
              trailingIcon: null,
              obsecured: false,
              controller: _carTypeController,
              filled: false,
              inputType: TextInputType.text),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomTextField(
              hintText: 'Car Model',
              trailingIcon: null,
              obsecured: false,
              controller: _carModelController,
              filled: false,
              inputType: TextInputType.emailAddress),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomTextField(
              hintText: 'Plate Number',
              trailingIcon: null,
              obsecured: false,
              controller: _plateNumberController,
              filled: false,
              inputType: TextInputType.text),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomButton(
            title: 'Add Car',
            onPress: () async {
              final result = await FirestoreDatabase.addCar(
                  _carTypeController.text,
                  _carModelController.text,
                  _plateNumberController.text,
                  'available');
              if (result) {
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
