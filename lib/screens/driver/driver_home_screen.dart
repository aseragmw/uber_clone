import 'package:flutter/material.dart';
import 'package:uber_clone_app/models/trip_model.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_constants.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/cache_manager.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class DriverHomeScreen extends StatefulWidget {
  DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
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
                  null, AppConstants.driverId),
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
                          Text('Car Fare : ${snapshot.data!.pickUp}'),
                          FutureBuilder(
                              future: FirestoreDatabase.getCustomer(
                                  snapshot.data!.customerID),
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
                                            'Customer : ${snapshot.data!.name}'),
                                        Text(
                                            'Phone Number : ${snapshot.data!.phoneNumber}'),
                                      ],
                                    );
                                  default:
                                    return CircularProgressIndicator();
                                }
                              }),
                          CustomButton(
                              title: 'Finish Trip',
                              onPress: () async {
                                final result =
                                    await FirestoreDatabase.finishTrip(
                                        snapshot.data!.tripId);
                                if (result) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Trip Finished')));
                                  setState(() {});
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Error accepting trip')));
                                }
                              },
                              buttonColor: AppTheme.redColor,
                              borderRadius: AppTheme.boxRadius,
                              borderColor: AppTheme.blackColor,
                              buttonWidth: context.screenWidth * 0.5,
                              buttonHeight: context.screenHeight * 0.07,
                              fontSize: AppTheme.fontSize12(context))
                        ],
                      );
                    } else {
                      return CustomButton(
                        title: 'View Available Trips',
                        onPress: () async {
                          await Navigator.of(context)
                              .pushNamed('viewAvailableTripsScreen');
                          setState(() {});
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
                Navigator.of(context).pushNamed('driverPreviousTripsScreen');
              },
              buttonColor: AppTheme.redColor,
              borderRadius: AppTheme.boxRadius,
              borderColor: AppTheme.blackColor,
              buttonWidth: context.screenWidth*0.7,
              buttonHeight: context.screenHeight*0.06,
              fontSize: AppTheme.fontSize12(context))
        ],
      ),
    );
  }
}
