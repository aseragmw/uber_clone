import 'package:flutter/material.dart';
import 'package:uber_clone_app/models/trip_model.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/cache_manager.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';
import 'package:uber_clone_app/widgets/trip_history_item.dart';

class ViewAvailableTripsScreen extends StatelessWidget {
  const ViewAvailableTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreDatabase.getInstance().getAvailableTrips(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const CircularProgressIndicator();

            case ConnectionState.done:
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No Available Trips',
                    style: TextStyle(
                        fontSize: AppTheme.fontSize12(context),
                        fontWeight: AppTheme.fontWeight500),
                  ),
                );
              }
              return SizedBox(
                height: context.screenHeight * 0.8,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return TripCard(trip: snapshot.data![index]);
                  },
                ),
              );
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip});
  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TripHistoryItem(keyy: 'Pick Up', value: trip.pickUp),
        TripHistoryItem(keyy: 'Destination', value: trip.destination),
        TripHistoryItem(keyy: 'Time', value: trip.time),
        TripHistoryItem(keyy: 'Car Fare', value: trip.carFare),
        FutureBuilder(
            future:
                FirestoreDatabase.getInstance().getCustomer(trip.customerID),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const CircularProgressIndicator();

                case ConnectionState.done:
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TripHistoryItem(
                          keyy: 'Customer', value: snapshot.data!.name),
                      TripHistoryItem(
                          keyy: 'Phone Number',
                          value: snapshot.data!.phoneNumber),
                    ],
                  );
                default:
                  return const CircularProgressIndicator();
              }
            }),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        CustomButton(
            title: 'Accept',
            onPress: () async {
              final driverId = await CacheManager.getValue('driverId');
              final result = await FirestoreDatabase.getInstance()
                  .acceptTrip(trip.tripId, driverId);
              if (result) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Trip Accepted')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error accepting trip')));
              }
            },
            buttonColor: AppTheme.transparentColor,
            borderRadius: AppTheme.boxRadius,
            borderColor: AppTheme.yellowColor,
            fontColor: AppTheme.yellowColor,
            buttonWidth: context.screenWidth * 0.8,
            buttonHeight: context.screenHeight * 0.08,
            fontSize: AppTheme.fontSize10(context)),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
        const Divider(),
        const SpacingSizedBox(height: true, width: false),
        const SpacingSizedBox(height: true, width: false),
      ],
    );
  }
}
