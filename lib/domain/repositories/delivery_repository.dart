import '../entities/delivery.dart';

abstract class DeliveryRepository {
  Future<List<Delivery>> fetchDeliveries();
  Future<void> updateStatus(String deliveryId, String status);
}
