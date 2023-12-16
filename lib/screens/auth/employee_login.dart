import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_app_bar.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/custom_text_field.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';
import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

class EmployeeLoginScreen extends StatelessWidget {
  EmployeeLoginScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBar(
              leadingWidget: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_ios_new_rounded),
                  SpacingSizedBox(height: false, width: true),
                  SpacingSizedBox(height: false, width: true),
                  Text(
                    'Back',
                    style: TextStyle(fontSize: AppTheme.fontSize8(context)),
                  ),
                ],
              ),
              trailingWidget: null,
              leadingOnTap: () {
                Navigator.of(context).pop();
              },
              trailingOnTap: null,
              centeredTitle: null),
          SizedBox(
            height: context.screenHeight * 0.05,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: context.screenWidth,
                child: Text(
                  'Employee Login',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: AppTheme.fontSize14(context),
                      fontWeight: AppTheme.fontWeight500),
                ),
              ),
              SpacingSizedBox(height: true, width: false),
              SpacingSizedBox(height: true, width: false),
              SpacingSizedBox(height: true, width: false),
              SpacingSizedBox(height: true, width: false),
              CustomTextField(
                  hintText: 'Email',
                  trailingIcon: null,
                  obsecured: false,
                  controller: _emailController,
                  filled: false,
                  inputType: TextInputType.emailAddress),
              SpacingSizedBox(height: true, width: false),
              SpacingSizedBox(height: true, width: false),
              SpacingSizedBox(height: true, width: false),
              CustomTextField(
                  hintText: 'Password',
                  trailingIcon: null,
                  obsecured: true,
                  controller: _passwordController,
                  filled: false,
                  inputType: TextInputType.text),
              SpacingSizedBox(height: true, width: false),
              SpacingSizedBox(height: true, width: false),
              SpacingSizedBox(height: true, width: false),
              SpacingSizedBox(height: true, width: false),
              SpacingSizedBox(height: true, width: false),
              CustomButton(
                title: 'Login',
                onPress: () async {
                  final loginResult = await BasicAuthProvider.getInstance().employee_login(
                      _emailController.text, _passwordController.text);
                  if (loginResult) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Center(child: Text("Logged In Successfuly"))));
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        'customerHomeScreen', (route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Center(child: Text("Login Failed"))));
                  }
                },
                buttonColor: AppTheme.yellowColor,
                borderRadius: AppTheme.boxRadius,
                borderColor: null,
                buttonWidth: context.screenWidth * 0.8,
                buttonHeight: context.screenHeight * 0.08,
                fontSize: AppTheme.fontSize10(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
// import 'package:uber_clone_app/utils/app_theme.dart';
// import 'package:uber_clone_app/utils/screen_size.dart';
// import 'package:uber_clone_app/widgets/custom_app_bar.dart';
// import 'package:uber_clone_app/widgets/custom_button.dart';
// import 'package:uber_clone_app/widgets/custom_text_field.dart';
// import 'package:uber_clone_app/widgets/main_layout.dart';
// import 'package:uber_clone_app/widgets/spacing_sized_box.dart';

// class EmployeeLoginScreen extends StatelessWidget {
//   EmployeeLoginScreen({super.key});
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return MainLayout(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CustomAppBar(
//               leadingWidget: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Icon(Icons.arrow_back_ios_new_rounded),
//                   SpacingSizedBox(height: false, width: true),
//                   SpacingSizedBox(height: false, width: true),
//                   Text(
//                     'Back',
//                     style: TextStyle(fontSize: AppTheme.fontSize8(context)),
//                   ),
//                 ],
//               ),
//               trailingWidget: null,
//               leadingOnTap: () {
//                 Navigator.of(context).pop();
//               },
//               trailingOnTap: null,
//               centeredTitle: null),
//           SizedBox(
//             height: context.screenHeight * 0.05,
//           ),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 width: context.screenWidth,
//                 child: Text(
//                   'Login',
//                   textAlign: TextAlign.start,
//                   style: TextStyle(
//                       fontSize: AppTheme.fontSize14(context),
//                       fontWeight: AppTheme.fontWeight500),
//                 ),
//               ),
//               SpacingSizedBox(height: true, width: false),
//               SpacingSizedBox(height: true, width: false),
//               SpacingSizedBox(height: true, width: false),
//               SpacingSizedBox(height: true, width: false),
//               CustomTextField(
//                   hintText: 'Email',
//                   trailingIcon: null,
//                   obsecured: false,
//                   controller: _emailController,
//                   filled: false,
//                   inputType: TextInputType.emailAddress),
//               SpacingSizedBox(height: true, width: false),
//               SpacingSizedBox(height: true, width: false),
//               SpacingSizedBox(height: true, width: false),
//               CustomTextField(
//                   hintText: 'Password',
//                   trailingIcon: null,
//                   obsecured: true,
//                   controller: _passwordController,
//                   filled: false,
//                   inputType: TextInputType.text),
//               SpacingSizedBox(height: true, width: false),
//               SpacingSizedBox(height: true, width: false),
//               SpacingSizedBox(height: true, width: false),
//               SpacingSizedBox(height: true, width: false),
//               SpacingSizedBox(height: true, width: false),
//               CustomButton(
//                 title: 'Login',
//                 onPress: () async {
//                   final loginResult = await BasicAuthProvider.login(
//                       _emailController.text, _passwordController.text);
//                   if (loginResult) {
//                     Navigator.of(context).pushNamed('customerHomeScreen');
//                   } else {
//                     ScaffoldMessenger.of(context)
//                         .showSnackBar(SnackBar(content: Text("error")));
//                   }
//                 },
//                 buttonColor: AppTheme.yellowColor,
//                 borderRadius: AppTheme.boxRadius,
//                 borderColor: null,
//                 buttonWidth: context.screenWidth * 0.8,
//                 buttonHeight: context.screenHeight * 0.08,
//                 fontSize: AppTheme.fontSize10(context),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: context.screenHeight * 0.05,
//           ),
//           Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(width: context.screenWidth * 0.4, child: Divider()),
//                 Text(
//                   'or',
//                   style: TextStyle(fontSize: AppTheme.fontSize10(context)),
//                 ),
//                 SizedBox(width: context.screenWidth * 0.4, child: Divider())
//               ],
//             ),
//           ),
//           SizedBox(
//             height: context.screenHeight * 0.05,
//           ),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).pushNamedAndRemoveUntil(
//                       'registerScreen', (route) => false);
//                 },
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "Don't you have an account? ",
//                       style: TextStyle(
//                         fontSize: AppTheme.fontSize8(context),
//                       ),
//                     ),
//                     Text(
//                       "Register",
//                       style: TextStyle(
//                           fontSize: AppTheme.fontSize8(context),
//                           color: AppTheme.yellowColor),
//                     ),
//                   ],
//                 ),
//               ),
//               SpacingSizedBox(height: true, width: false),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).pushNamedAndRemoveUntil(
//                       "driverLoginScreen", (route) => false);
//                 },
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "Login as ",
//                       style: TextStyle(
//                         fontSize: AppTheme.fontSize8(context),
//                       ),
//                     ),
//                     Text(
//                       "Driver",
//                       style: TextStyle(
//                           fontSize: AppTheme.fontSize8(context),
//                           color: AppTheme.yellowColor),
//                     ),
//                   ],
//                 ),
//               ),
//               SpacingSizedBox(height: true, width: false),
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context).pushNamedAndRemoveUntil(
//                       "employeeLoginScreen", (route) => false);
//                 },
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "Login as ",
//                       style: TextStyle(
//                         fontSize: AppTheme.fontSize8(context),
//                       ),
//                     ),
//                     Text(
//                       "Employee",
//                       style: TextStyle(
//                           fontSize: AppTheme.fontSize8(context),
//                           color: AppTheme.yellowColor),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
// // import 'package:uber_clone_app/utils/app_theme.dart';
// // import 'package:uber_clone_app/utils/screen_size.dart';
// // import 'package:uber_clone_app/widgets/custom_button.dart';
// // import 'package:uber_clone_app/widgets/custom_text_field.dart';
// // import 'package:uber_clone_app/widgets/main_layout.dart';

// // class EmployeeLoginScreen extends StatelessWidget {
// //   EmployeeLoginScreen({super.key});
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return MainLayout(
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           SizedBox(
// //             height: context.screenHeight * 0.02,
// //           ),

// //           CustomTextField(
// //               hintText: 'Email',
// //               trailingIcon: null,
// //               obsecured: false,
// //               controller: _emailController,
// //               filled: false,
// //               inputType: TextInputType.emailAddress),
// //           SizedBox(
// //             height: context.screenHeight / 50,
// //           ),
// //           CustomTextField(
// //               hintText: 'Password',
// //               trailingIcon: null,
// //               obsecured: true,
// //               controller: _passwordController,
// //               filled: false,
// //               inputType: TextInputType.text),
// //           SizedBox(
// //             height: context.screenHeight / 50,
// //           ),
// //           // CustomTextField(
// //           //     hintText: 'Phone Number',
// //           //     trailingIcon: null,
// //           //     obsecured: false,
// //           //     controller: _phoneNumberController,
// //           //     filled: false,
// //           //     inputType: TextInputType.number),
// //           SizedBox(
// //             height: context.screenHeight / 50,
// //           ),
// //           CustomButton(
// //             title: 'Login',
// //             onPress: () async {
// //               final loginResult = await BasicAuthProvider.employee_login(
// //                   _emailController.text, _passwordController.text);
// //               if (loginResult) {
// //                 Navigator.of(context).pushNamedAndRemoveUntil(
// //                     'employeeHomeScreen', (route) => false);
// //               } else {
// //                 ScaffoldMessenger.of(context)
// //                     .showSnackBar(SnackBar(content: Text("Failed")));
// //               }
// //             },
// //             buttonColor: AppTheme.redColor,
// //             borderRadius: AppTheme.boxRadius,
// //             borderColor: AppTheme.blackColor,
// //             buttonWidth: context.screenWidth * 0.7,
// //             buttonHeight: context.screenHeight * 0.08,
// //             fontSize: AppTheme.fontSize12(context),
// //           ),
// //           SizedBox(
// //             height: context.screenHeight / 50,
// //           ),
// //           Text(
// //             "Don't you have an account?",
// //             style: TextStyle(
// //               fontSize: context.screenHeight / context.screenWidth * 10,
// //               color: Color.fromRGBO(9, 77, 61, 1),
// //             ),
// //           ),
// //           SizedBox(
// //             height: context.screenHeight / 50,
// //           ),
// //           CustomButton(
// //               title: 'Register',
// //               onPress: () {
// //                 Navigator.of(context).pushNamedAndRemoveUntil(
// //                     'registerScreen', (route) => false);
// //               },
// //               buttonColor: AppTheme.redColor,
// //               borderRadius: AppTheme.boxRadius,
// //               borderColor: AppTheme.blackColor,
// //               buttonWidth: context.screenWidth * 0.7,
// //               buttonHeight: context.screenHeight * 0.08,
// //               fontSize: AppTheme.fontSize12(context)),
// //           SizedBox(
// //             height: context.screenHeight / 50,
// //           ),
// //           CustomButton(
// //               title: 'Driver?',
// //               onPress: () {
// //                 Navigator.of(context).pushNamedAndRemoveUntil(
// //                     "driverLoginScreen", (route) => false);
// //               },
// //               buttonColor: AppTheme.redColor,
// //               borderRadius: AppTheme.boxRadius,
// //               borderColor: AppTheme.blackColor,
// //               buttonWidth: context.screenWidth * 0.7,
// //               buttonHeight: context.screenHeight * 0.08,
// //               fontSize: AppTheme.fontSize12(context)),
// //           SizedBox(
// //             height: context.screenHeight / 50,
// //           ),
// //           CustomButton(
// //               title: 'Customer?',
// //               onPress: () {
// //                 Navigator.of(context)
// //                     .pushNamedAndRemoveUntil("loginScreen", (route) => false);
// //               },
// //               buttonColor: AppTheme.redColor,
// //               borderRadius: AppTheme.boxRadius,
// //               borderColor: AppTheme.blackColor,
// //               buttonWidth: context.screenWidth * 0.7,
// //               buttonHeight: context.screenHeight * 0.08,
// //               fontSize: AppTheme.fontSize12(context)),
// //         ],
// //       ),
// //     );
// //   }
// // }
