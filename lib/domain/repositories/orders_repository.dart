import '../entities/order.dart';

abstract class OrdersRepository {
  Future<List<Order>> fetchOrders();
  Future<void> submitOrder(Order order);
}
