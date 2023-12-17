abstract class Vehicle {
  late String carModel;
  late String carType;
  late String plateNumber;
  late String status;
  late String docId;
  Vehicle(
      this.carModel, this.carType, this.plateNumber, this.status, this.docId);
  Vehicle clone();
}
