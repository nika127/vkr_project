import '../../domain/entities/order.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/mock_data_source.dart';

class MockOrdersRepository implements OrdersRepository {
  MockOrdersRepository(this._dataSource);

  final MockDataSource _dataSource;

  @override
  Future<List<Order>> fetchOrders() async {
    return _dataSource.orders;
  }

  @override
  Future<void> submitOrder(Order order) async {
    _dataSource.orders = [..._dataSource.orders, order];
  }
}
