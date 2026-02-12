import '../../domain/entities/delivery.dart';

class DeliveryModel extends Delivery {
  const DeliveryModel({
    required super.id,
    required super.driverName,
    required super.status,
    required super.routeDistanceKm,
  });

  factory DeliveryModel.fromMap(Map<String, dynamic> data, String id) {
    return DeliveryModel(
      id: id,
      driverName: data['driverName'] as String? ?? 'Водитель',
      status: data['status'] as String? ?? 'в пути',
      routeDistanceKm: (data['routeDistanceKm'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'driverName': driverName,
      'status': status,
      'routeDistanceKm': routeDistanceKm,
    };
  }
}
