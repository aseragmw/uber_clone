import 'package:uber_clone_app/models/vehicle_model.dart';

class Car extends Vehicle {
  @override
  Car clone() {
    return Car('','','','','');
  }

  Car(String carModel, String carType, String plateNumber, String status,
      String docId)
      : super(carModel, carType, plateNumber, status, docId);
}
