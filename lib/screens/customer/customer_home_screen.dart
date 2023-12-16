import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone_app/screens/customer/add_complain_screen.dart';
import 'package:uber_clone_app/screens/customer/book_trip_screen.dart';
import 'package:uber_clone_app/screens/customer/customer_previous_trips_screen.dart';
import 'package:uber_clone_app/screens/customer/update_profile_screen.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_app_bar.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class CustomerHomeScreen extends StatefulWidget {
  CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  int _selectedIndex = 0;

  List<Widget> tabItems = [
    Home(),
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
          CustomAppBar(
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
            activeColor: AppTheme.yellowColor,
            icon: Icon(Icons.car_rental),
            title: Text('Book Trip'),
          ),
          FlashyTabBarItem(
            activeColor: AppTheme.yellowColor,
            icon: Icon(Icons.history),
            title: Text('Trips History'),
          ),
          FlashyTabBarItem(
            activeColor: AppTheme.yellowColor,
            icon: Icon(Icons.warning),
            title: Text('Complaint'),
          ),
          FlashyTabBarItem(
            activeColor: AppTheme.yellowColor,
            icon: Icon(Icons.face),
            title: Text('Profile'),
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
            BasicAuthProvider.getInstance().currentCustome().uid, null),
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
                        future: FirestoreDatabase.getInstance().getDriver(
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
                                  Text('Driver : ${snapshot.data!.fullname}'),
                                  Text(
                                      'Phone Number : ${snapshot.data!.phoneNumber}'),
                                  FutureBuilder(
                                      future: FirestoreDatabase.getInstance().getCar(
                                          snapshot.data!.carRef),
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
                return BookTripScreen();
              }
            default:
              return CircularProgressIndicator();
          }
        }));
  }
}


// Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: context.screenHeight * 0.02,
//           ),
//           FutureBuilder(
//               future: FirestoreDatabase.checkForOnProgressTrip(
//                   BasicAuthProvider.currentCustome().uid, null),
//               builder: ((context, snapshot) {
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.waiting:
//                   case ConnectionState.active:
//                     return CircularProgressIndicator();

//                   case ConnectionState.done:
//                     if (snapshot.data != null) {
//                       return Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text('Pick Up : ${snapshot.data!.pickUp}'),
//                           Text('Destination : ${snapshot.data!.destination}'),
//                           Text('Time : ${snapshot.data!.time}'),
//                           Text('Car Fare : ${snapshot.data!.carFare}'),
//                           FutureBuilder(
//                               future: FirestoreDatabase.getDriver(
//                                   snapshot.data!.driverID),
//                               builder: (context, snapshot) {
//                                 switch (snapshot.connectionState) {
//                                   case ConnectionState.waiting:
//                                   case ConnectionState.active:
//                                     return CircularProgressIndicator();

//                                   case ConnectionState.done:
//                                     return Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                             'Driver : ${snapshot.data!.fullname}'),
//                                         Text(
//                                             'Phone Number : ${snapshot.data!.phoneNumber}'),
//                                         FutureBuilder(
//                                             future: FirestoreDatabase.getCar(
//                                                 snapshot.data!.carRef),
//                                             builder: (context, snapshot) {
//                                               switch (
//                                                   snapshot.connectionState) {
//                                                 case ConnectionState.waiting:
//                                                 case ConnectionState.active:
//                                                   return CircularProgressIndicator();

//                                                 case ConnectionState.done:
//                                                   return Column(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     children: [
//                                                       Text(
//                                                           'Car Type : ${snapshot.data!.carType}'),
//                                                       Text(
//                                                           'Car Model : ${snapshot.data!.carModel}'),
//                                                       Text(
//                                                           'plate Number : ${snapshot.data!.plate_number}'),
//                                                     ],
//                                                   );
//                                                 default:
//                                                   return CircularProgressIndicator();
//                                               }
//                                             }),
//                                       ],
//                                     );
//                                   default:
//                                     return CircularProgressIndicator();
//                                 }
//                               }),
//                         ],
//                       );
//                     } else {
//                       return CustomButton(
//                         title: 'Book a Trip',
//                         onPress: () {
//                           Navigator.of(context).pushNamed('bookTripScreen');
//                         },
//                         buttonColor: AppTheme.redColor,
//                         borderRadius: AppTheme.boxRadius,
//                         borderColor: AppTheme.blackColor,
//                         buttonWidth: context.screenWidth * 0.7,
//                         buttonHeight: context.screenHeight * 0.08,
//                         fontSize: AppTheme.fontSize12(context),
//                       );
//                     }
//                   default:
//                     return CircularProgressIndicator();
//                 }
//               })),
//           SizedBox(
//             height: context.screenHeight * 0.02,
//           ),
//           CustomButton(
//               title: 'Previous Trips',
//               onPress: () {
//                 Navigator.of(context).pushNamed('customerPreviousTripsScreen');
//               },
//               buttonColor: AppTheme.redColor,
//               borderRadius: AppTheme.boxRadius,
//               borderColor: AppTheme.blackColor,
//               buttonWidth: context.screenWidth * 0.7,
//               buttonHeight: context.screenHeight * 0.06,
//               fontSize: AppTheme.fontSize12(context)),
//           SizedBox(
//             height: context.screenHeight * 0.02,
//           ),
//           CustomButton(
//               title: 'Add Complain',
//               onPress: () {
//                 Navigator.of(context).pushNamed('addComplainScreen');
//               },
//               buttonColor: AppTheme.redColor,
//               borderRadius: AppTheme.boxRadius,
//               borderColor: AppTheme.blackColor,
//               buttonWidth: context.screenWidth * 0.7,
//               buttonHeight: context.screenHeight * 0.06,
//               fontSize: AppTheme.fontSize12(context)),
//           SizedBox(
//             height: context.screenHeight * 0.02,
//           ),
//           CustomButton(
//             title: 'Update Profile',
//             onPress: () {
//               Navigator.of(context).pushNamed('updateProfileScreen');
//             },
//             buttonColor: AppTheme.redColor,
//             borderRadius: AppTheme.boxRadius,
//             borderColor: AppTheme.blackColor,
//             buttonWidth: context.screenWidth * 0.7,
//             buttonHeight: context.screenHeight * 0.08,
//             fontSize: AppTheme.fontSize12(context),
//           )
//         ],
//       ),
      