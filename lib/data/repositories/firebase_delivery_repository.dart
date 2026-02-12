import '../../domain/entities/delivery.dart';
import '../../domain/repositories/delivery_repository.dart';
import '../datasources/firebase_datasource.dart';
import '../models/delivery_model.dart';

class FirebaseDeliveryRepository implements DeliveryRepository {
  FirebaseDeliveryRepository(this._dataSource);

  final FirebaseDataSource _dataSource;

  @override
  Future<List<Delivery>> fetchDeliveries() async {
    final data = await _dataSource.fetchCollection('deliveries');
    return data
        .asMap()
        .entries
        .map((entry) {
      final id = entry.value['id']?.toString() ?? entry.key.toString();
      return DeliveryModel.fromMap(entry.value, id);
    })
        .toList();
  }

  @override
  Future<void> updateStatus(String deliveryId, String status) async {
    await _dataSource.setDocument('deliveries/$deliveryId', {'status': status});
  }
}
