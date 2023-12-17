import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone_app/models/VehicleManager.dart';
import 'package:uber_clone_app/models/complain_model.dart';
import 'package:uber_clone_app/models/customer_model.dart';
import 'package:uber_clone_app/models/driver_model.dart';
import 'package:uber_clone_app/models/trip_model.dart';
import 'package:uber_clone_app/models/vehicle_model.dart';
import 'package:uber_clone_app/services/auth/basic_auth_provider.dart';

class FirestoreDatabase {
  static FirestoreDatabase? _instance = null;
  VehicleManager vehicleManager = VehicleManager();

  static FirestoreDatabase getInstance() {
    if (_instance == null) {
      _instance = FirestoreDatabase();
    }
    return _instance!;
  }

  // FirestoreDatabase._() {}

  final firestore = FirebaseFirestore.instance;
  Future<bool> addDriver(
      String fullname,
      String email,
      String password,
      String phoneNumber,
      String carType,
      String carModel,
      String plateNumber,
      Vehicle? selectedCar) async {
    try {
      if (carType.isNotEmpty && carModel.isNotEmpty && plateNumber.isNotEmpty) {
        late String carRef;
        await firestore.collection("cars").add({
          "car_type": carType,
          "car_model": carModel,
          "plate_number": plateNumber,
          "status": 'unavailable'
        }).then((value) => carRef = value.id);
        await firestore.collection("drivers").add({
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
    } catch (e) {
      return false;
    }
  }

  Future<bool> addCar(
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

  Future<bool> addComplain(String complain, String customerId) async {
    try {
      await firestore
          .collection("complains")
          .add({"complain": complain, 'customerId': customerId});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Vehicle> getCar(String carId) async {
    try {
      late Vehicle car;
      await firestore.collection("cars").doc(carId).get().then((value) async {
        log(value.data().toString());
        car = VehicleManager.createVehicle('car');
        log('here 1');
        car.carModel = value.data()!['car_model'];
        log('here2');
        car.carType = value.data()!['car_type'];
        log('here 3');
        car.plateNumber = value.data()!['plate_number'];
        log('here 4');
        car.status = value.data()!['status'];
        log('here 5');
        car.docId = value.id;
        log('here 6');
        // car = Car(
        //     carModel: value.data()!['car_model'],
        //     carType: value.data()!['car_type'],
        //     plate_number: value.data()!['plate_number'],
        //     status: value.data()!['status'],
        //     docId: value.id);
      });
      return car;
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }

  Future<List<TripModel>> getPreviousTrips(
      String? customerId, String? driverId) async {
    try {
      List<TripModel> trips = [];
      if (customerId != null) {
        final tripsData = await firestore
            .collection('trips')
            .where('customerID', isEqualTo: customerId)
            .where('status', isEqualTo: 'finished')
            .get();
        for (var element in tripsData.docs) {
          trips.add(
            TripModel(
                customerID: element.data()['customerID'],
                tripId: element.id,
                driverID: element.data()['driverID'],
                carFare: element.data()['car_fare'],
                destination: element.data()['destination'],
                pickUp: element.data()['pick_up'],
                status: element.data()['status'],
                time: element.data()['time'],
                tripRate: element.data()['trip_rate']),
          );
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
              time: element.data()['time'],
              tripRate: element.data()['trip_rate']));
        }
      }
      return trips;
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<ComplainModel>> getComplaints() async {
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

  Future<List<Vehicle>> getAllCars() async {
    try {
      final List<Vehicle> cars = [];
      final snapshot = await firestore.collection('cars').get();

      for (var e in snapshot.docs) {
        Vehicle car = VehicleManager.createVehicle('car');
        car.carModel = e.data()['car_model'];
        car.carType = e.data()['car_type'];
        car.plateNumber = e.data()['plate_number'];
        car.status = e.data()['status'];
        car.docId = e.id;
        cars.add(car);
      }

      return cars;
    } catch (e) {
      throw Exception();
    }
  }

  Future<bool> bookTrip(
      String pickUp, String destination, String time, String carFare) async {
    try {
      await firestore.collection('trips').add({
        'pick_up': pickUp,
        'destination': destination,
        'time': time,
        'car_fare': carFare,
        'customerID': BasicAuthProvider.getInstance().currentCustomer().uid,
        'driverID': '',
        'status': 'pending',
        'trip_rate': ''
      });
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<TripModel>> getAvailableTrips() async {
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
            tripId: element.id,
            tripRate: element.data()['trip_rate']));
      }
      return trips;
    } catch (e) {
      return [];
    }
  }

  Future<CustomerModel> getCustomer(String customerId) async {
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

  Future<DriverModel> getDriver(String driverId) async {
    try {
      late DriverModel driver;
      await firestore
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

  Future<bool> acceptTrip(String tripId, String driverId) async {
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

  Future<bool> finishTrip(String tripId) async {
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

  Future<bool> rateTrip(String tripId, String rate) async {
    try {
      await firestore
          .collection('trips')
          .doc(tripId)
          .update({'trip_rate': rate});
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<TripModel?> checkForOnProgressTrip(
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
            time: trip.docs.first.data()['time'],
            tripRate: trip.docs.first.data()['trip_rate']);
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
            time: trip.docs.first.data()['time'],
            tripRate: trip.docs.first.data()['trip_rate']);
      }
    } catch (e) {
      return null;
    }
  }
}
