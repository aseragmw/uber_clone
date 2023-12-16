import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class BookTripScreen extends StatelessWidget {
  BookTripScreen({super.key});
  final _pickUpController = TextEditingController();
  final _destenationController = TextEditingController();
  final _tripTimeController = TextEditingController();

  final _carFareTimeController = TextEditingController();

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
              hintText: 'detailed pick up address',
              trailingIcon: null,
              obsecured: false,
              controller: _pickUpController,
              filled: false,
              inputType: TextInputType.text),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomTextField(
              hintText: 'Detailed destenation',
              trailingIcon: null,
              obsecured: false,
              controller: _destenationController,
              filled: false,
              inputType: TextInputType.emailAddress),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomTextField(
              hintText: 'Trip time',
              trailingIcon: null,
              obsecured: false,
              controller: _tripTimeController,
              filled: false,
              inputType: TextInputType.text),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomTextField(
              hintText: 'carFare',
              trailingIcon: null,
              obsecured: false,
              controller: _carFareTimeController,
              filled: false,
              inputType: TextInputType.text),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomButton(
            title: 'Confirm Trip',
            onPress: () async {
              final result = await FirestoreDatabase.bookTrip(
                  _pickUpController.text,
                  _destenationController.text,
                  _tripTimeController.text,
                  _carFareTimeController.text);
              if (result) {
                 ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Trip Confirmed")));
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
