import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

class AddCarScreen extends StatelessWidget {
  AddCarScreen({super.key});
  final _carTypeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _plateNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField(
            hintText: 'Car Type',
            trailingIcon: null,
            obsecured: false,
            controller: _carTypeController,
            filled: false,
            inputType: TextInputType.text),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomTextField(
            hintText: 'Car Model',
            trailingIcon: null,
            obsecured: false,
            controller: _carModelController,
            filled: false,
            inputType: TextInputType.emailAddress),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomTextField(
            hintText: 'Plate Number',
            trailingIcon: null,
            obsecured: false,
            controller: _plateNumberController,
            filled: false,
            inputType: TextInputType.text),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomButton(
          title: 'Add Car',
          onPress: () async {
            final result = await FirestoreDatabase.getInstance().addCar(
                _carTypeController.text,
                _carModelController.text,
                _plateNumberController.text,
                'available');
            if (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Center(child: Text("Car Added"))));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Center(child: Text("Error Occured"))));
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
