import 'package:flutter/material.dart';
import 'package:uber_clone_app/models/trip_model.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/cache_manager.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class ViewAvailableTripsScreen extends StatelessWidget {
  ViewAvailableTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: FutureBuilder(
          future: FirestoreDatabase.getAvailableTrips(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                return CircularProgressIndicator();

              case ConnectionState.done:
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No Available Trips'),
                  );
                }
                return SizedBox(
                  height: context.screenHeight * 0.8,
                  child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),

                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return TripCard(trip: snapshot.data![index]);
                    },
                  ),
                );
              default:
                return CircularProgressIndicator();
            }
          }),
    );
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
        Text('Pick Up : ${trip.pickUp}'),
        Text('Destination : ${trip.destination}'),
        Text('Time : ${trip.time}'),
        Text('Car Fare : ${trip.pickUp}'),
        FutureBuilder(
            future: FirestoreDatabase.getCustomer(trip.customerID),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return CircularProgressIndicator();

                case ConnectionState.done:
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Customer : ${snapshot.data!.name}'),
                      Text('Phone Number : ${snapshot.data!.phoneNumber}'),
                    ],
                  );
                default:
                  return CircularProgressIndicator();
              }
            }),
        CustomButton(
            title: 'Accept',
            onPress: () async {
              final driverId = await CacheManager.getValue('driverId');
              final result = await FirestoreDatabase.acceptTrip(
                trip.tripId,driverId
              );
              if (result) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Trip Accepted')));
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error accepting trip')));
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
  }
}
