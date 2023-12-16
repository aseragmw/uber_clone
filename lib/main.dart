import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone_app/firebase_options.dart';
import 'package:uber_clone_app/screens/auth/add_phone_number_screen.dart';
import 'package:uber_clone_app/screens/auth/driver_login.dart';
import 'package:uber_clone_app/screens/auth/employee_login.dart';
import 'package:uber_clone_app/screens/auth/login_screen.dart';
import 'package:uber_clone_app/screens/auth/register_screen.dart';
import 'package:uber_clone_app/screens/auth/welcome_sceree.dart';
import 'package:uber_clone_app/screens/customer/add_complain_screen.dart';
import 'package:uber_clone_app/screens/customer/book_trip_screen.dart';
import 'package:uber_clone_app/screens/customer/change_password_screen.dart';
import 'package:uber_clone_app/screens/customer/customer_home_screen.dart';
import 'package:uber_clone_app/screens/customer/customer_previous_trips_screen.dart';
import 'package:uber_clone_app/screens/customer/update_profile_screen.dart';
import 'package:uber_clone_app/screens/driver/driver_home_screen.dart';
import 'package:uber_clone_app/screens/driver/driver_previous_trips_screen.dart';
import 'package:uber_clone_app/screens/driver/view_available_trips_screen.dart';
import 'package:uber_clone_app/screens/empolyee/add_car_screen.dart';
import 'package:uber_clone_app/screens/empolyee/add_driver_screen.dart';
import 'package:uber_clone_app/screens/empolyee/employee_home_screen.dart';
import 'package:uber_clone_app/screens/empolyee/view_complaints_screen.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/utils/app_constants.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
      AppConstants.initAppConstants();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "loginScreen": (context) => LoginScreen(),
        "driverLoginScreen": (context) => DriverLoginScreen(),
        "employeeLoginScreen": (context) => EmployeeLoginScreen(),
        "registerScreen": (context) => RegisterScreen(),
        "addPhoneNumberScreen": (context) => AddPhoneNumberScreen(),
        "addDriverScreen": (context) => AddDriverScreen(),
        "addCarScreen": (context) => AddCarScreen(),
        "employeeHomeScreen": (context) => EmployeeHomeScreen(),
        "customerHomeScreen": (context) => CustomerHomeScreen(),
        "driverHomeScreen": (context) => DriverHomeScreen(),
        "viewAvailableTripsScreen": (context) => ViewAvailableTripsScreen(),
        "bookTripScreen": (context) => BookTripScreen(),
        "customerPreviousTripsScreen": (context) => CustomerPreviousTripsScreen(),
        "driverPreviousTripsScreen": (context) => DriverrPreviousTripsScreen(),
        "addComplainScreen": (context) => AddComplainScreen(),
        "viewComplaintsScreen": (context) => ViewComplaintsScreen(),
        "updateProfileScreen": (context) => UpdateProfileScreen(),
        "changePasswordScreen": (context) => ChangePasswordScreen(),
                "welcomeScreen": (context) => WelcomeScreen(),






      },
      home: WelcomeScreen(),
    );
  }
}
