import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone_app/screens/empolyee/add_car_screen.dart';
import 'package:uber_clone_app/screens/empolyee/add_driver_screen.dart';
import 'package:uber_clone_app/screens/empolyee/view_complaints_screen.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_app_bar.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({super.key});

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

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    const AddDriverScreen(),
    AddCarScreen(),
    const ViewComplaintsScreen(),
    const EmployeeProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
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
            icon: const Icon(Icons.face),
            title: const Text('Add Driver'),
          ),
          FlashyTabBarItem(
            activeColor: AppTheme.yellowColor,
            icon: const Icon(Icons.car_repair),
            title: const Text('Add A Car'),
          ),
          FlashyTabBarItem(
            activeColor: AppTheme.yellowColor,
            icon: const Icon(Icons.warning),
            title: const Text('Complaints'),
          ),
          FlashyTabBarItem(
            activeColor: AppTheme.yellowColor,
            icon: const Icon(Icons.face),
            title: const Text('Profile'),
          ),
        ],
      ),
     
      
    );
  }
}
