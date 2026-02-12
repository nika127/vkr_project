import '../../domain/entities/delivery.dart';
import '../../domain/repositories/delivery_repository.dart';
import '../datasources/mock_data_source.dart';

class MockDeliveryRepository implements DeliveryRepository {
  MockDeliveryRepository(this._dataSource);

  final MockDataSource _dataSource;

  @override
  Future<List<Delivery>> fetchDeliveries() async {
    return _dataSource.deliveries;
  }

  @override
  Future<void> updateStatus(String deliveryId, String status) async {
    _dataSource.deliveries = _dataSource.deliveries
        .map(
          (delivery) => delivery.id == deliveryId
              ? Delivery(
                  id: delivery.id,
                  driverName: delivery.driverName,
                  status: status,
                  routeDistanceKm: delivery.routeDistanceKm,
                )
              : delivery,
        )
        .toList();
  }
}
