class TripModel {
  final String customerID;
  final String driverID;
  final String carFare;
  final String destination;
  final String pickUp;
  final String status;
  final String time;
  final String tripId;
  final String tripRate;

  TripModel(
      {required this.customerID,
      required this.tripRate, 
      required this.tripId,
      required this.driverID,
      required this.carFare,
      required this.destination,
      required this.pickUp,
      required this.status,
      required this.time});
}
