import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone_app/models/car_model.dart';
import 'package:uber_clone_app/models/complain_model.dart';
import 'package:uber_clone_app/models/customer_model.dart';
import 'package:uber_clone_app/models/driver_model.dart';
import 'package:uber_clone_app/models/trip_model.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';

class FirestoreDatabase {
  static final firestore = FirebaseFirestore.instance;
  static Future<bool> addDriver(
      String fullname,
      String email,
      String password,
      String phoneNumber,
      String carType,
      String carModel,
      String plateNumber,
      Car? selectedCar) async {
    try {
      if (carType.isNotEmpty && carModel.isNotEmpty && plateNumber.isNotEmpty) {
        late String carRef;
        await firestore.collection("cars").add({
          "car_type": carType,
          "car_model": carModel,
          "plate_number": plateNumber,
          "status": 'unavailable'
        }).then((value) => carRef = value.id);
        final docRef = await firestore.collection("drivers").add({
          "fullname": fullname,
          "email": email,
          "password": password,
          "phoneNumber": phoneNumber,
          'car_ref': carRef
        });
        return true;
      } else if (selectedCar != null) {
        await firestore
            .collection('cars')
            .doc(selectedCar.docId)
            .update({'status': 'unavailable'});
        await firestore.collection("drivers").add({
          "fullname": fullname,
          "email": email,
          "password": password,
          "phoneNumber": phoneNumber,
          'car_ref': selectedCar.docId
        });
        return true;
      } else {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addCar(
    String carType,
    String carModel,
    String plateNumber,
    String status,
  ) async {
    try {
      await firestore.collection("cars").add({
        "car_type": carType,
        "car_model": carModel,
        "plate_number": plateNumber,
        "status": status
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addComplain(String complain, String customerId) async {
    try {
      await firestore
          .collection("complains")
          .add({"complain": complain, 'customerId': customerId});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Car> getCar(String carId) async {
    try {
      late Car car;
      await firestore.collection("cars").doc(carId).get().then((value) async {
        car = Car(
            carModel: value.data()!['car_model'],
            carType: value.data()!['car_type'],
            plate_number: value.data()!['plate_number'],
            status: value.data()!['status'],
            docId: value.id);
      });
      return car;
    } catch (e) {
      throw Exception();
    }
  }

  static Future<List<TripModel>> getPreviousTrips(
      String? customerId, String? driverId) async {
    try {
      List<TripModel> trips = [];
      if (customerId != null) {
        final tripsData = await firestore
            .collection('trips')
            .where('customerID', isEqualTo: customerId)
            .get();
        for (var element in tripsData.docs) {
          trips.add(TripModel(
              customerID: element.data()['customerID'],
              tripId: element.id,
              driverID: element.data()['driverID'],
              carFare: element.data()['car_fare'],
              destination: element.data()['destination'],
              pickUp: element.data()['pick_up'],
              status: element.data()['status'],
              time: element.data()['time']));
        }
      } else {
        final tripsData = await firestore
            .collection('trips')
            .where('driverID', isEqualTo: driverId)
            .get();
        for (var element in tripsData.docs) {
          trips.add(TripModel(
              customerID: element.data()['customerID'],
              tripId: element.id,
              driverID: element.data()['driverID'],
              carFare: element.data()['car_fare'],
              destination: element.data()['destination'],
              pickUp: element.data()['pick_up'],
              status: element.data()['status'],
              time: element.data()['time']));
        }
      }
      return trips;
    } catch (e) {
      throw Exception();
    }
  }

  static Future<List<ComplainModel>> getComplaints() async {
    try {
      List<ComplainModel> complaints = [];
      final comapinsData = await firestore.collection('complains').get();
      for (var element in comapinsData.docs) {
        complaints.add(ComplainModel(
            customerId: element.data()['customerId'],
            complain: element.data()['complain']));
      }

      return complaints;
    } catch (e) {
      throw Exception();
    }
  }

  static Future<List<Car>> getAllCars() async {
    try {
      final List<Car> cars = [];
      log('here 1');
      final snapshot = await firestore.collection('cars').get();
      log('here2');
      // log(snapshot.docs.first.data().toString());
      log('here 3');

      for (var e in snapshot.docs) {
        log('here 4');
        cars.add(Car(
            carModel: e.data()['car_model'],
            carType: e.data()['car_type'],
            plate_number: e.data()['plate_number'],
            status: e.data()['status'],
            docId: e.id));
      }
      log('here 5');

      return cars;
    } catch (e) {
      throw Exception();
    }
  }

  static Future<bool> bookTrip(
      String pickUp, String destination, String time, String carFare) async {
    try {
      await firestore.collection('trips').add({
        'pick_up': pickUp,
        'destination': destination,
        'time': time,
        'car_fare': carFare,
        'customerID': BasicAuthProvider.currentCustome(),
        'driverID': '',
        'status': 'pending'
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<TripModel>> getAvailableTrips() async {
    try {
      List<TripModel> trips = [];
      final query = await firestore
          .collection('trips')
          .where('status', isEqualTo: 'pending')
          .get();
      for (var element in query.docs) {
        trips.add(TripModel(
            customerID: element.data()['customerID'],
            driverID: element.data()['driverID'],
            carFare: element.data()['car_fare'],
            destination: element.data()['destination'],
            pickUp: element.data()['pick_up'],
            status: element.data()['status'],
            time: element.data()['time'],
            tripId: element.id));
      }
      return trips;
    } catch (e) {
      return [];
    }
  }

  static Future<CustomerModel> getCustomer(String customerId) async {
    try {
      late CustomerModel customer;
      final docRef = await firestore
          .collection('customers')
          .where('customer_id', isEqualTo: customerId)
          .get();
      await firestore
          .collection('customers')
          .doc(docRef.docs.first.id)
          .get()
          .then((value) async {
        customer = CustomerModel(
            customerId: value.data()!['customer_id'],
            email: value.data()!['email'],
            name: value.data()!['name'],
            phoneNumber: value.data()!['phone_number']);
      });
      return customer;
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  static Future<DriverModel> getDriver(String driverId) async {
    try {
      late DriverModel driver;
      final docRef = await firestore
          .collection('drivers')
          .doc(driverId)
          .get()
          .then((value) async {
        driver = DriverModel(
            carRef: value.data()!['car_ref'],
            email: value.data()!['email'],
            fullname: value.data()!['fullname'],
            phoneNumber: value.data()!['phoneNumber']);
      });

      return driver;
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  static Future<bool> acceptTrip(String tripId, String driverId) async {
    try {
      await firestore
          .collection('trips')
          .doc(tripId)
          .update({'status': 'on_progress', 'driverID': driverId});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> finishTrip(String tripId) async {
    try {
      await firestore
          .collection('trips')
          .doc(tripId)
          .update({'status': 'finished'});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<TripModel?> checkForOnProgressTrip(
      String? customerId, String? driverId) async {
    try {
      if (driverId != null) {
        final trip = await firestore
            .collection('trips')
            .where('driverID', isEqualTo: driverId)
            .where('status', isEqualTo: 'on_progress')
            .get();
        return TripModel(
            customerID: trip.docs.first.data()['customerID'],
            tripId: trip.docs.first.id,
            driverID: trip.docs.first.data()['driverID'],
            carFare: trip.docs.first.data()['car_fare'],
            destination: trip.docs.first.data()['destination'],
            pickUp: trip.docs.first.data()['pick_up'],
            status: trip.docs.first.data()['status'],
            time: trip.docs.first.data()['time']);
      } else {
        final trip = await firestore
            .collection('trips')
            .where('customerID', isEqualTo: customerId)
            .where('status', isEqualTo: 'on_progress')
            .get();
        return TripModel(
            customerID: trip.docs.first.data()['customerID'],
            tripId: trip.docs.first.id,
            driverID: trip.docs.first.data()['driverID'],
            carFare: trip.docs.first.data()['car_fare'],
            destination: trip.docs.first.data()['destination'],
            pickUp: trip.docs.first.data()['pick_up'],
            status: trip.docs.first.data()['status'],
            time: trip.docs.first.data()['time']);
      }
    } catch (e) {
      return null;
    }
  }
}
