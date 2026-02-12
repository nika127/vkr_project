import '../entities/order.dart';
import '../repositories/orders_repository.dart';

class SubmitOrder {
  SubmitOrder(this._repository);

  final OrdersRepository _repository;

  Future<void> call(Order order) {
    return _repository.submitOrder(order);
  }
}
