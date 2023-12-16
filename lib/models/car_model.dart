import 'package:uber_clone_app/models/vehicle_model.dart';

class Car extends Vehicle {
  @override
  Car clone() {
    return Car('','','','','');
  }

  // Car.fromJson(
  //     {required this.carModel,
  //     required this.carType,
  //     required this.plate_number,
  //     required this.status,
  //     required this.docId});

  Car(String carModel, String carType, String plate_number, String status,
      String docId)
      : super(carModel, carType, plate_number, status, docId);
}
