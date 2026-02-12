class Order {
  const Order({
    required this.id,
    required this.clientName,
    required this.address,
    required this.status,
    required this.total,
  });

  final String id;
  final String clientName;
  final String address;
  final String status;
  final double total;
}
