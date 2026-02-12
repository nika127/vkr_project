class Delivery {
  const Delivery({
    required this.id,
    required this.driverName,
    required this.status,
    required this.routeDistanceKm,
  });

  final String id;
  final String driverName;
  final String status;
  final double routeDistanceKm;
}
