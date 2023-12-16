import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';
import 'package:uber_clone_app/utils/app_constants.dart';
import 'package:uber_clone_app/utils/app_theme.dart';
import 'package:uber_clone_app/utils/screen_size.dart';
import 'package:uber_clone_app/widgets/custom_button.dart';
import 'package:uber_clone_app/widgets/main_layout.dart';

class ViewComplaintsScreen extends StatelessWidget {
  ViewComplaintsScreen({super.key});

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
              future: FirestoreDatabase.getComplaints(),
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
                              Text(
                                  'Complain : ${snapshot.data![index].complain}'),
                              FutureBuilder(
                                  future: FirestoreDatabase.getCustomer(
                                      snapshot.data![index].customerId),
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
                                                'Name : ${snapshot.data!.name}'),
                                            Text(
                                                'Phone Number : ${snapshot.data!.phoneNumber}'),
                                            Text(
                                                'Email : ${snapshot.data!.email}'),
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
