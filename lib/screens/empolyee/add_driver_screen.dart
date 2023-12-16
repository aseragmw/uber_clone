import 'package:flutter/material.dart';
import 'package:uber_clone_app/models/car_model.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class AddDriverScreen extends StatefulWidget {
  AddDriverScreen({super.key});

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
  Car? selectedCar;

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
              hintText: 'Full Name',
              trailingIcon: null,
              obsecured: false,
              controller: _fullnameController,
              filled: false,
              inputType: TextInputType.text),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomTextField(
              hintText: 'Email',
              trailingIcon: null,
              obsecured: false,
              controller: _emailController,
              filled: false,
              inputType: TextInputType.emailAddress),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomTextField(
              hintText: 'Password',
              trailingIcon: null,
              obsecured: false,
              controller: _passwordController,
              filled: false,
              inputType: TextInputType.text),
          SizedBox(
            height: context.screenHeight / 50,
          ),
          CustomTextField(
              hintText: 'Phone Number',
              trailingIcon: null,
              obsecured: false,
              controller: _phoneNumberController,
              filled: false,
              inputType: TextInputType.text),
          SizedBox(
            height: context.screenHeight / 50,
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
          // CustomButton(
          //   title: 'Add Car',
          //   onPress: () async {
          //     final result = await FirestoreDatabase.addCar(
          //         _carTypeController.text,
          //         _carModelController.text,
          //         _plateNumberController.text);
          //     if (result) {
          //       Navigator.of(context).pop();
          //     } else {
          //       ScaffoldMessenger.of(context)
          //           .showSnackBar(SnackBar(content: Text("Error Occured")));
          //     }
          //   },
          //   buttonColor: AppTheme.redColor,
          //   borderRadius: AppTheme.boxRadius,
          //   borderColor: AppTheme.blackColor,
          //   buttonWidth: context.screenWidth * 0.7,
          //   buttonHeight: context.screenHeight * 0.08,
          //   fontSize: AppTheme.fontSize12(context),
          // ),
          Divider(),
          Text('Link Car'),
          FutureBuilder(
              future: FirestoreDatabase.getAllCars(),
              builder: ((context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return CircularProgressIndicator();
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
                                  selectedCar = element;
                                }
                              }
                            });
                          },
                        ),
                      );
                    } else {
                      return SizedBox();
                    }

                  default:
                    return CircularProgressIndicator();
                }
              })),
          //  SizedBox(
          //       width: context.screenWidth * 0.8,
          //       child: DropdownButtonFormField<String>(
          //         decoration: const InputDecoration(
          //             border: OutlineInputBorder(
          //               borderRadius: AppTheme.boxRadius,
          //             ),
          //             filled: true,
          //             fillColor: AppTheme.whiteColor),
          //         value: selectedTime,
          //         items: timesList.map((value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //         onChanged: (newValue) {
          //           setState(() {
          //             selectedTime = newValue!;
          //             servicesList.clear();
          //           });
          //         },
          //       ),
          //     ),
          CustomButton(
            title: 'Add Driver',
            onPress: () async {
              final result = await FirestoreDatabase.addDriver(
                  _fullnameController.text,
                  _emailController.text,
                  _passwordController.text,
                  _phoneNumberController.text,
                  _carTypeController.text,
                  _carModelController.text,
                  _plateNumberController.text,
                  selectedCar);
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
