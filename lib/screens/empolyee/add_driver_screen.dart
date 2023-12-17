import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uber_clone_app/models/vehicle_model.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

class AddDriverScreen extends StatefulWidget {
  const AddDriverScreen({super.key});

  @override
  State<AddDriverScreen> createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  final _fullnameController = TextEditingController();

  final _carTypeController = TextEditingController();

  final _carModelController = TextEditingController();

  final _plateNumberController = TextEditingController();

  late String selectedCarString;
  Vehicle? selectedCar;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomTextField(
            hintText: 'Full Name',
            trailingIcon: null,
            obsecured: false,
            controller: _fullnameController,
            filled: false,
            inputType: TextInputType.text),
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
        CustomTextField(
            hintText: 'Password',
            trailingIcon: null,
            obsecured: false,
            controller: _passwordController,
            filled: false,
            inputType: TextInputType.text),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomTextField(
            hintText: 'Phone Number',
            trailingIcon: null,
            obsecured: false,
            controller: _phoneNumberController,
            filled: false,
            inputType: TextInputType.text),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
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

        
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: context.screenWidth * 0.4, child: const Divider()),
              Text(
                'or',
                style: TextStyle(fontSize: AppTheme.fontSize10(context)),
              ),
              SizedBox(width: context.screenWidth * 0.4, child: const Divider())
            ],
          ),
        ),
        const SpacingSizedBox(height: true, width: false),

        Text(
          'Link A Car',
          style: TextStyle(fontSize: AppTheme.fontSize10(context)),
        ),
        const SpacingSizedBox(height: true, width: false),

        FutureBuilder(
            future: FirestoreDatabase.getInstance().getAllCars(),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.data!.isNotEmpty) {
                    selectedCarString = snapshot.data!.first.carModel;
                    return SizedBox(
                      width: context.screenWidth * 0.8,
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: AppTheme.boxRadius,
                            ),
                            filled: true,
                            fillColor: AppTheme.whiteColor),
                        value: selectedCarString,
                        items: snapshot.data!
                            .where((element) => element.status == "available")
                            .map((value) {
                          return DropdownMenuItem<String>(
                            value: value.carModel,
                            child: Text(value.carModel),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCarString = newValue!;
                            for (var element in snapshot.data!) {
                              if (element.carModel == newValue) {
                                log(element.carModel);
                                selectedCar = element;
                              }
                            }
                          });
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }

                default:
                  return const CircularProgressIndicator();
              }
            })),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomButton(
          title: 'Add Driver',
          onPress: () async {
            final result = await FirestoreDatabase.getInstance().addDriver(
                _fullnameController.text,
                _emailController.text,
                _passwordController.text,
                _phoneNumberController.text,
                _carTypeController.text,
                _carModelController.text,
                _plateNumberController.text,
                selectedCar);
            if (result) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Center(child: Text("Driver Added"))));
           
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Center(child: Text("Error Occured"))));
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
