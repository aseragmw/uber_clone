import 'package:uber_clone_app/models/vehicle_model.dart';

class VehicleManager {
  static Map<String, Vehicle> _vehiclePrototypes = {};

  static void registerPrototype(String key, Vehicle vehicle) {
    _vehiclePrototypes[key] = vehicle;
  }

  static Vehicle createVehicle(String key) {
    return _vehiclePrototypes[key]!.clone();
  }
}