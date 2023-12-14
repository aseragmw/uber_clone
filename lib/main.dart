import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone_app/firebase_options.dart';
import 'package:uber_clone_app/screens/auth/add_phone_number_screen.dart';
import 'package:uber_clone_app/screens/auth/login_screen.dart';
import 'package:uber_clone_app/screens/auth/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      ),routes: {
          "loginScreen": (context) => LoginScreen(),
          "registerScreen": (context) => RegisterScreen(),
                    "addPhoneNumberScreen": (context) => AddPhoneNumberScreen(),

        },
      home: RegisterScreen(),
    );
  }
}
