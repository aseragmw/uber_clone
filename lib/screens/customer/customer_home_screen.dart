import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class CustomerHomeScreen extends StatelessWidget {
  CustomerHomeScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.screenHeight * 0.02,
          ),
          FutureBuilder(
              future: FirestoreDatabase.checkForOnProgressTrip(
                  BasicAuthProvider.currentCustome().uid, null),
              builder: ((context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return CircularProgressIndicator();

                  case ConnectionState.done:
                    if (snapshot.data != null) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Pick Up : ${snapshot.data!.pickUp}'),
                          Text('Destination : ${snapshot.data!.destination}'),
                          Text('Time : ${snapshot.data!.time}'),
                          Text('Car Fare : ${snapshot.data!.carFare}'),
                          FutureBuilder(
                              future: FirestoreDatabase.getDriver(
                                  snapshot.data!.driverID),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                  case ConnectionState.active:
                                    return CircularProgressIndicator();

                                  case ConnectionState.done:
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            'Driver : ${snapshot.data!.fullname}'),
                                        Text(
                                            'Phone Number : ${snapshot.data!.phoneNumber}'),
                                        FutureBuilder(
                                            future: FirestoreDatabase.getCar(
                                                snapshot.data!.carRef),
                                            builder: (context, snapshot) {
                                              switch (
                                                  snapshot.connectionState) {
                                                case ConnectionState.waiting:
                                                case ConnectionState.active:
                                                  return CircularProgressIndicator();

                                                case ConnectionState.done:
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          'Car Type : ${snapshot.data!.carType}'),
                                                      Text(
                                                          'Car Model : ${snapshot.data!.carModel}'),
                                                      Text(
                                                          'plate Number : ${snapshot.data!.plate_number}'),
                                                    ],
                                                  );
                                                default:
                                                  return CircularProgressIndicator();
                                              }
                                            }),
                                      ],
                                    );
                                  default:
                                    return CircularProgressIndicator();
                                }
                              }),
                        ],
                      );
                    } else {
                      return CustomButton(
                        title: 'Book a Trip',
                        onPress: () {
                          Navigator.of(context).pushNamed('bookTripScreen');
                        },
                        buttonColor: AppTheme.redColor,
                        borderRadius: AppTheme.boxRadius,
                        borderColor: AppTheme.blackColor,
                        buttonWidth: context.screenWidth * 0.7,
                        buttonHeight: context.screenHeight * 0.08,
                        fontSize: AppTheme.fontSize12(context),
                      );
                    }
                  default:
                    return CircularProgressIndicator();
                }
              })),
          SizedBox(
            height: context.screenHeight * 0.02,
          ),
          CustomButton(
              title: 'Previous Trips',
              onPress: () {
                Navigator.of(context).pushNamed('customerPreviousTripsScreen');
              },
              buttonColor: AppTheme.redColor,
              borderRadius: AppTheme.boxRadius,
              borderColor: AppTheme.blackColor,
              buttonWidth: context.screenWidth * 0.7,
              buttonHeight: context.screenHeight * 0.06,
              fontSize: AppTheme.fontSize12(context)),
          SizedBox(
            height: context.screenHeight * 0.02,
          ),
          CustomButton(
              title: 'Add Complain',
              onPress: () {
                Navigator.of(context).pushNamed('addComplainScreen');
              },
              buttonColor: AppTheme.redColor,
              borderRadius: AppTheme.boxRadius,
              borderColor: AppTheme.blackColor,
              buttonWidth: context.screenWidth * 0.7,
              buttonHeight: context.screenHeight * 0.06,
              fontSize: AppTheme.fontSize12(context)),
          SizedBox(
            height: context.screenHeight * 0.02,
          ),
          CustomButton(
            title: 'Update Profile',
            onPress: () {
              Navigator.of(context).pushNamed('updateProfileScreen');
            },
            buttonColor: AppTheme.redColor,
            borderRadius: AppTheme.boxRadius,
            borderColor: AppTheme.blackColor,
            buttonWidth: context.screenWidth * 0.7,
            buttonHeight: context.screenHeight * 0.08,
            fontSize: AppTheme.fontSize12(context),
          )
        ],
      ),
    );
  }
}
