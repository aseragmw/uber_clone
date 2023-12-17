import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';
import 'package:uber_clone_app/widgets/trip_history_item.dart';

class CustomerPreviousTripsScreen extends StatefulWidget {
  CustomerPreviousTripsScreen({super.key});

  @override
  State<CustomerPreviousTripsScreen> createState() =>
      _CustomerPreviousTripsScreenState();
}

class _CustomerPreviousTripsScreenState
    extends State<CustomerPreviousTripsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(
            future: FirestoreDatabase.getInstance().getPreviousTrips(
                BasicAuthProvider.getInstance().currentCustomer().uid, null),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const CircularProgressIndicator();

                case ConnectionState.done:
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final TextEditingController _rateConroller =
                        TextEditingController();

                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
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
                              TripHistoryItem(
                                  keyy: 'Trip Rate',
                                  value: snapshot.data![index].tripRate),
                              FutureBuilder(
                                  future: FirestoreDatabase.getInstance()
                                      .getDriver(
                                          snapshot.data![index].driverID),
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
                                                keyy: 'Driver',
                                                value: snapshot.data!.fullname),
                                            TripHistoryItem(
                                                keyy: 'Number',
                                                value:
                                                    snapshot.data!.phoneNumber),
                                            FutureBuilder(
                                                future: FirestoreDatabase
                                                        .getInstance()
                                                    .getCar(
                                                        snapshot.data!.carRef),
                                                builder: (context, snapshot) {
                                                  switch (snapshot
                                                      .connectionState) {
                                                    case ConnectionState
                                                          .waiting:
                                                    case ConnectionState.active:
                                                      return const CircularProgressIndicator();

                                                    case ConnectionState.done:
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          TripHistoryItem(
                                                              keyy: 'Car Type',
                                                              value: snapshot
                                                                  .data!
                                                                  .carType),
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
                                                                  .plateNumber),
                                                        ],
                                                      );
                                                    default:
                                                      return const CircularProgressIndicator();
                                                  }
                                                }),
                                          ],
                                        );
                                      default:
                                        return const CircularProgressIndicator();
                                    }
                                  }),
                              const SpacingSizedBox(height: true, width: false),
                              snapshot.data![index].tripRate == ''
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: context.screenHeight * 0.08,
                                          width: context.screenWidth * 0.4,
                                          child: CustomTextField(
                                            hintText: 'Rate from 1 to 5',
                                            trailingIcon: null,
                                            obsecured: false,
                                            controller: _rateConroller,
                                            filled: false,
                                            inputType: TextInputType.number,
                                          ),
                                        ),
                                        CustomButton(
                                            title: 'Rate Driver',
                                            onPress: () async {
                                              final result =
                                                  await FirestoreDatabase
                                                          .getInstance()
                                                      .rateTrip(
                                                          snapshot.data![index]
                                                              .tripId,
                                                          _rateConroller.text
                                                              .toString());
                                              if (result) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Center(
                                                  child: Text('Rate Added'),
                                                )));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Center(
                                                  child: Text('Error Occured'),
                                                )));
                                              }
                                              setState(() {});
                                            },
                                            buttonColor:
                                                AppTheme.transparentColor,
                                            borderRadius: AppTheme.boxRadius,
                                            borderColor: AppTheme.yellowColor,
                                            buttonWidth:
                                                context.screenWidth * 0.4,
                                            buttonHeight:
                                                context.screenHeight * 0.08,
                                            fontColor: AppTheme.yellowColor,
                                            fontSize:
                                                AppTheme.fontSize10(context)),
                                      ],
                                    )
                                  : const SizedBox(),
                              const SpacingSizedBox(height: true, width: false),
                              const Divider(),
                            ],
                          );
                        });
                  } else {
                    return Center(
                      child: Text(
                        'No Previous Trips',
                        style: TextStyle(
                            fontSize: AppTheme.fontSize12(context),
                            fontWeight: AppTheme.fontWeight500),
                      ),
                    );
                  }
                default:
                  return const CircularProgressIndicator();
              }
            })),
      ],
    );
  }
}
