import 'package:flutter/material.dart';
import 'package:uber_clone_app/services/firestore/firestore_database.dart';


class ViewComplaintsScreen extends StatelessWidget {
  const ViewComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(
            future: FirestoreDatabase.getInstance().getComplaints(),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const CircularProgressIndicator();

                case ConnectionState.done:
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                'Complain : ${snapshot.data![index].complain}'),
                            FutureBuilder(
                                future: FirestoreDatabase.getInstance()
                                    .getCustomer(
                                        snapshot.data![index].customerId),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.active:
                                      return const CircularProgressIndicator();

                                    case ConnectionState.done:
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Name : ${snapshot.data!.name}'),
                                          Text(
                                              'Phone Number : ${snapshot.data!.phoneNumber}'),
                                          Text(
                                              'Email : ${snapshot.data!.email}'),
                                        ],
                                      );
                                    default:
                                      return const CircularProgressIndicator();
                                  }
                                }),
                            const Divider(),
                          ],
                        );
                      });
                default:
                  return const CircularProgressIndicator();
              }
            })),
      ],
    );
  }
}
