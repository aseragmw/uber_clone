import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone_app/screens/customer/add_complain_screen.dart';
import 'package:uber_clone_app/screens/customer/book_trip_screen.dart';
import 'package:uber_clone_app/screens/customer/customer_previous_trips_screen.dart';
import 'package:uber_clone_app/screens/customer/update_profile_screen.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/widgets/custom_app_bar.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';
import 'package:uber_clone_app/widgets/trip_history_item.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    const Home(),
    CustomerPreviousTripsScreen(),
    AddComplainScreen(),
    UpdateProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomAppBar(
            leadingWidget: null,
            trailingWidget: null,
            leadingOnTap: null,
            trailingOnTap: null,
            centeredTitle: 'Tawseela',
            titleColor: AppTheme.yellowColor,
          ),
          tabItems[_selectedIndex]
        ],
      ),
      bottomNavBar: FlashyTabBar(
        animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        iconSize: 30,
        showElevation: false, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            inactiveColor: AppTheme.blackColor,
            activeColor: AppTheme.yellowColor,
            icon: const Icon(Icons.car_rental),
            title: const Text('Book Trip'),
          ),
          FlashyTabBarItem(
            inactiveColor: AppTheme.blackColor,
            activeColor: AppTheme.yellowColor,
            icon: const Icon(Icons.history),
            title: const Text('Trips History'),
          ),
          FlashyTabBarItem(
            inactiveColor: AppTheme.blackColor,
            activeColor: AppTheme.yellowColor,
            icon: const Icon(Icons.warning),
            title: const Text('Complaint'),
          ),
          FlashyTabBarItem(
            inactiveColor: AppTheme.blackColor,
            activeColor: AppTheme.yellowColor,
            icon: const Icon(Icons.face),
            title: const Text('Profile'),
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreDatabase.getInstance().checkForOnProgressTrip(
            BasicAuthProvider.getInstance().currentCustomer().uid, null),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const CircularProgressIndicator();

            case ConnectionState.done:
              if (snapshot.data != null) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ongoing Trip',
                      style: TextStyle(
                          fontSize: AppTheme.fontSize12(context),
                          fontWeight: AppTheme.fontWeight500),
                    ),
                    const SpacingSizedBox(height: true, width: false),
                    const Divider(),
                    const SpacingSizedBox(height: true, width: false),
                    TripHistoryItem(
                        keyy: 'Pick Up', value: snapshot.data!.pickUp),
                    TripHistoryItem(
                        keyy: 'Destination', value: snapshot.data!.destination),
                    TripHistoryItem(keyy: 'Time', value: snapshot.data!.time),
                    TripHistoryItem(
                        keyy: 'Car Fare', value: snapshot.data!.carFare),
                    FutureBuilder(
                        future: FirestoreDatabase.getInstance()
                            .getDriver(snapshot.data!.driverID),
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
                                      keyy: 'Phone Number',
                                      value: snapshot.data!.phoneNumber),
                                  FutureBuilder(
                                      future: FirestoreDatabase.getInstance()
                                          .getCar(snapshot.data!.carRef),
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
                                                    keyy: 'Car Type',
                                                    value:
                                                        snapshot.data!.carType),
                                                TripHistoryItem(
                                                    keyy: 'Car Model',
                                                    value: snapshot
                                                        .data!.carModel),
                                                TripHistoryItem(
                                                    keyy: 'plate Number',
                                                    value: snapshot
                                                        .data!.plateNumber),
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
                  ],
                );
              } else {
                return BookTripScreen();
              }
            default:
              return const CircularProgressIndicator();
          }
        }));
  }
}
