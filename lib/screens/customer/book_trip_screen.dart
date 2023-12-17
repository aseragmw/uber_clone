import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

class BookTripScreen extends StatelessWidget {
  BookTripScreen({super.key});
  final _pickUpController = TextEditingController();
  final _destenationController = TextEditingController();
  final _tripTimeController = TextEditingController();

  final _carFareTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomTextField(
            hintText: 'Detailed Pick Up Address',
            trailingIcon: null,
            obsecured: false,
            controller: _pickUpController,
            filled: false,
            inputType: TextInputType.text),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomTextField(
            hintText: 'Detailed Destenation',
            trailingIcon: null,
            obsecured: false,
            controller: _destenationController,
            filled: false,
            inputType: TextInputType.emailAddress),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomTextField(
            hintText: 'Trip Time',
            trailingIcon: null,
            obsecured: false,
            controller: _tripTimeController,
            filled: false,
            inputType: TextInputType.text),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomTextField(
            hintText: 'Car Fare',
            trailingIcon: null,
            obsecured: false,
            controller: _carFareTimeController,
            filled: false,
            inputType: TextInputType.text),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomButton(
          title: 'Confirm Trip',
          onPress: () async {
            final result = await FirestoreDatabase.getInstance().bookTrip(
                _pickUpController.text,
                _destenationController.text,
                _tripTimeController.text,
                _carFareTimeController.text);
            if (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Trip Confirmed")));
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
      ],
    );
  }
}
