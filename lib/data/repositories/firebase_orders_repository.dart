import '../../domain/entities/order.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/firebase_datasource.dart';
import '../models/order_model.dart';

class FirebaseOrdersRepository implements OrdersRepository {
  FirebaseOrdersRepository(this._dataSource);

  final FirebaseDataSource _dataSource;

  @override
  Future<List<Order>> fetchOrders() async {
    final data = await _dataSource.fetchCollection('orders');
    return data
        .asMap()
        .entries
        .map((entry) {
      final id = entry.value['id']?.toString() ?? entry.key.toString();
      return OrderModel.fromMap(entry.value, id);
    })
        .toList();
  }

  @override
  Future<void> submitOrder(Order order) async {
    final model = OrderModel(
      id: order.id,
      clientName: order.clientName,
      address: order.address,
      status: order.status,
      total: order.total,
    );
    await _dataSource.setDocument('orders/${order.id}', model.toMap());
  }
}
