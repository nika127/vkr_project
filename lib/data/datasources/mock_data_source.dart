import '../../domain/entities/order.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/delivery.dart';

class MockDataSource {
  List<Product> products = [
    const Product(
      id: 'p1',
      name: 'Ювелирный набор',
      description: 'Золото 585, комплект серьги + кольцо',
      price: 1499.99,
      stock: 12,
      imageUrl: 'https://images.unsplash.com/photo-1518544801976-3e159e50e5bb',
    ),
    const Product(
      id: 'p2',
      name: 'Цепочка',
      description: 'Золото 585, 45 см',
      price: 799.0,
      stock: 24,
      imageUrl: 'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3',
    ),
    const Product(
      id: 'p3',
      name: 'Подвеска',
      description: 'Золото 585, с фианитом',
      price: 459.5,
      stock: 8,
      imageUrl: 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2',
    ),
  ];

  List<Order> orders = [
    const Order(
      id: 'AGP-001',
      clientName: 'Магазин "Золотой Дом"',
      address: 'Минск, пр. Независимости, 10',
      status: 'в обработке',
      total: 3200.5,
    ),
  ];

  List<Delivery> deliveries = [
    const Delivery(
      id: 'D-012',
      driverName: 'Иван Павлов',
      status: 'в пути',
      routeDistanceKm: 12.4,
    ),
  ];
}
