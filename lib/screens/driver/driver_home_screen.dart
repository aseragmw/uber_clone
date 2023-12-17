import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone_app/screens/driver/driver_previous_trips_screen.dart';
import 'package:uber_clone_app/screens/driver/view_available_trips_screen.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_constants.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_app_bar.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';
import 'package:uber_clone_app/widgets/trip_history_item.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    const Home(),
    const DriverrPreviousTripsScreen(),
    const DriverProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return MainLayout(
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
            activeColor: AppTheme.yellowColor,
            icon: const Icon(Icons.map_outlined),
            title: const Text('Trips'),
          ),
          FlashyTabBarItem(
            activeColor: AppTheme.yellowColor,
            icon: const Icon(Icons.history),
            title: const Text('History'),
          ),
          FlashyTabBarItem(
            activeColor: AppTheme.yellowColor,
            icon: const Icon(Icons.face),
            title: const Text('Pofile'),
          ),
        ],
      ),

      body: Column(
        children: [
          const CustomAppBar(
            leadingWidget: null,
            trailingWidget: null,
            leadingOnTap: null,
            trailingOnTap: null,
            centeredTitle: 'Tawseela Employee App',
            titleColor: AppTheme.yellowColor,
          ),
          tabItems[_selectedIndex],
        ],
      ),
      
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreDatabase.getInstance()
            .checkForOnProgressTrip(null, AppConstants.driverId),
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
                    TripHistoryItem(
                        keyy: 'Pick Up', value: snapshot.data!.pickUp),
                    TripHistoryItem(
                        keyy: 'Destination', value: snapshot.data!.destination),
                    TripHistoryItem(keyy: 'Time', value: snapshot.data!.time),
                    TripHistoryItem(
                        keyy: 'Car Fare', value: snapshot.data!.pickUp),
                    FutureBuilder(
                        future: FirestoreDatabase.getInstance()
                            .getCustomer(snapshot.data!.customerID),
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
                                      keyy: 'Customer',
                                      value: snapshot.data!.name),
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
                        title: 'Finish Trip',
                        onPress: () async {
                          final result = await FirestoreDatabase.getInstance()
                              .finishTrip(snapshot.data!.tripId);
                          if (result) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Trip Finished')));
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Error accepting trip')));
                          }
                        },
                        buttonColor: AppTheme.transparentColor,
                        borderRadius: AppTheme.boxRadius,
                        borderColor: AppTheme.yellowColor,
                        fontColor: AppTheme.yellowColor,
                        buttonWidth: context.screenWidth * 0.8,
                        buttonHeight: context.screenHeight * 0.08,
                        fontSize: AppTheme.fontSize12(context)),
                  ],
                );
              } else {
                return const ViewAvailableTripsScreen();
              }
            default:
              return const CircularProgressIndicator();
          }
        }));
  }
}

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
          title: 'Log Out',
          onPress: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('welcomeScreen', (route) => false);
          },
          buttonColor: AppTheme.yellowColor,
          borderRadius: AppTheme.boxRadius,
          borderColor: null,
          buttonWidth: context.screenWidth * 0.8,
          buttonHeight: context.screenHeight * 0.08,
          fontSize: AppTheme.fontSize10(context)),
    );
  }
}
