class CustomerModel {
  final String customerId;
  final String name;
  final String phoneNumber;
  final String email;

  CustomerModel(
      {required this.customerId,
      required this.email,
      required this.name,
      required this.phoneNumber});
}
