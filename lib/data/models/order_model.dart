import '../../domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.clientName,
    required super.address,
    required super.status,
    required super.total,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data, String id) {
    return OrderModel(
      id: id,
      clientName: data['clientName'] as String? ?? 'Клиент',
      address: data['address'] as String? ?? '',
      status: data['status'] as String? ?? 'новый',
      total: (data['total'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientName': clientName,
      'address': address,
      'status': status,
      'total': total,
    };
  }
}
