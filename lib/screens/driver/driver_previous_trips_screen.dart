import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_constants.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/trip_history_item.dart';

class DriverrPreviousTripsScreen extends StatelessWidget {
  const DriverrPreviousTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: context.screenHeight * 0.02,
        ),
        FutureBuilder(
            future: FirestoreDatabase.getInstance()
                .getPreviousTrips(null, AppConstants.driverId),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const CircularProgressIndicator(
                    color: AppTheme.yellowColor,
                  );

                case ConnectionState.done:
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TripHistoryItem(
                                keyy: 'Status',
                                value: snapshot.data![index].status),
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
                            TripHistoryItem(
                                keyy: 'Trip Rate',
                                value: snapshot.data![index].tripRate),
                            FutureBuilder(
                                future: FirestoreDatabase.getInstance()
                                    .getCustomer(
                                        snapshot.data![index].customerID),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.active:
                                      return const CircularProgressIndicator(
                                        color: AppTheme.yellowColor,
                                      );

                                    case ConnectionState.done:
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TripHistoryItem(
                                              keyy: 'Customer',
                                              value: snapshot.data!.name),
                                          TripHistoryItem(
                                              keyy: 'Phone Number',
                                              value:
                                                  snapshot.data!.phoneNumber),
                                        ],
                                      );
                                    default:
                                      return const CircularProgressIndicator(
                                        color: AppTheme.yellowColor,
                                      );
                                  }
                                }),
                            const Divider(),
                          ],
                        );
                      });
                default:
                  return const CircularProgressIndicator(
                    color: AppTheme.yellowColor,
                  );
              }
            })),
      ],
    );
  }
}
