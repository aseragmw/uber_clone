import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

class CustomerPreviousTripsScreen extends StatelessWidget {
  CustomerPreviousTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(
            future: FirestoreDatabase.getInstance().getPreviousTrips(
                BasicAuthProvider.getInstance().currentCustome().uid, null),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return CircularProgressIndicator();

                case ConnectionState.done:
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TripHistoryItem(
                                keyy: 'Pick Up',
                                value: snapshot.data![index].pickUp),
                            TripHistoryItem(
                                keyy: 'Destination',
                                value: snapshot.data![index].destination),
                            TripHistoryItem(
                                keyy: 'Time',
                                value: snapshot.data![index].time),
                            TripHistoryItem(
                                keyy: 'Car Fare',
                                value: snapshot.data![index].carFare),
                            FutureBuilder(
                                future: FirestoreDatabase.getInstance().getDriver(
                                    snapshot.data![index].driverID),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.active:
                                      return CircularProgressIndicator();

                                    case ConnectionState.done:
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TripHistoryItem(
                                              keyy: 'Driver',
                                              value: snapshot.data!.fullname),
                                          TripHistoryItem(
                                              keyy: 'Number',
                                              value:
                                                  snapshot.data!.phoneNumber),
                                          FutureBuilder(
                                              future: FirestoreDatabase.getInstance().getCar(
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
                                                        TripHistoryItem(
                                                            keyy: 'Car Type',
                                                            value: snapshot
                                                                .data!.carType),
                                                        TripHistoryItem(
                                                            keyy: 'Car Model',
                                                            value: snapshot
                                                                .data!
                                                                .carModel),
                                                        TripHistoryItem(
                                                            keyy:
                                                                'Plate Number',
                                                            value: snapshot
                                                                .data!
                                                                .plate_number),
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
                            SpacingSizedBox(height: true, width: false),
                            CustomButton(
                                title: 'Rate Driver',
                                onPress: () {},
                                buttonColor: AppTheme.transparentColor,
                                borderRadius: AppTheme.boxRadius,
                                borderColor: AppTheme.yellowColor,
                                buttonWidth: context.screenWidth * 0.5,
                                buttonHeight: context.screenHeight * 0.08,
                                fontColor: AppTheme.yellowColor,
                                fontSize: AppTheme.fontSize10(context)),
                            SpacingSizedBox(height: true, width: false),
                            Divider(),
                          ],
                        );
                      });
                default:
                  return CircularProgressIndicator();
              }
            })),
      ],
    );
  }
}

class TripHistoryItem extends StatelessWidget {
  const TripHistoryItem({super.key, required this.keyy, required this.value});
  final String keyy;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.screenAspectRatio * 5),
      margin: EdgeInsets.symmetric(vertical: context.screenAspectRatio * 2),
      decoration: BoxDecoration(
        color: AppTheme.yellowColor,
        borderRadius: AppTheme.boxRadius,
      ),
      width: context.screenWidth * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${keyy}',
            style: TextStyle(
                fontSize: AppTheme.fontSize8(context),
                fontWeight: AppTheme.fontWeight400),
          ),
          Text(
            '${value}',
            style: TextStyle(
                fontSize: AppTheme.fontSize8(context),
                fontWeight: AppTheme.fontWeight400),
          ),
        ],
      ),
    );
  }
}
