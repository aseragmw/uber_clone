abstract class Vehicle {
  late String carModel;
  late String carType;
  late String plate_number;
  late String status;
  late String docId;
  Vehicle(this.carModel,this.carType,this.plate_number,this.status,this.docId);
  Vehicle clone();
}
