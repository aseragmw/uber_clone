import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class CustomerPreviousTripsScreen extends StatelessWidget {
  CustomerPreviousTripsScreen({super.key});

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
              future: FirestoreDatabase.getPreviousTrips(
                  BasicAuthProvider.currentCustome().uid, null),
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
                              Text('Status : ${snapshot.data![index].status}'),
                              Text('Pick Up : ${snapshot.data![index].pickUp}'),
                              Text(
                                  'Destination : ${snapshot.data![index].destination}'),
                              Text('Time : ${snapshot.data![index].time}'),
                              Text(
                                  'Car Fare : ${snapshot.data![index].carFare}'),
                              FutureBuilder(
                                  future: FirestoreDatabase.getDriver(
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
                                            Text(
                                                'Driver : ${snapshot.data!.fullname}'),
                                            Text(
                                                'Phone Number : ${snapshot.data!.phoneNumber}'),
                                            FutureBuilder(
                                                future:
                                                    FirestoreDatabase.getCar(
                                                        snapshot.data!.carRef),
                                                builder: (context, snapshot) {
                                                  switch (snapshot
                                                      .connectionState) {
                                                    case ConnectionState
                                                          .waiting:
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
                              Divider(),
                            ],
                          );
                        });
                  default:
                    return CircularProgressIndicator();
                }
              })),
        ],
      ),
    );
  }
}
