import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/app_config.dart';
import '../../data/datasources/firebase_datasource.dart';
import '../../data/datasources/mock_data_source.dart';
import '../../data/repositories/firebase_catalog_repository.dart';
import '../../data/repositories/firebase_delivery_repository.dart';
import '../../data/repositories/firebase_orders_repository.dart';
import '../../data/repositories/firebase_warehouse_repository.dart';
import '../../data/repositories/mock_catalog_repository.dart';
import '../../data/repositories/mock_delivery_repository.dart';
import '../../data/repositories/mock_orders_repository.dart';
import '../../data/repositories/mock_warehouse_repository.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../../domain/repositories/delivery_repository.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../domain/repositories/warehouse_repository.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  return const AppConfig(useFirebase: false);
});

final mockDataSourceProvider = Provider<MockDataSource>((ref) {
  return MockDataSource();
});

final firebaseDataSourceProvider = Provider<FirebaseDataSource>((ref) {
  return FirebaseDataSource();
});

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  final useFirebase = ref.watch(appConfigProvider).useFirebase;
  if (useFirebase) {
    return FirebaseCatalogRepository(ref.read(firebaseDataSourceProvider));
  }
  return MockCatalogRepository(ref.read(mockDataSourceProvider));
});

final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  final useFirebase = ref.watch(appConfigProvider).useFirebase;
  if (useFirebase) {
    return FirebaseOrdersRepository(ref.read(firebaseDataSourceProvider));
  }
  return MockOrdersRepository(ref.read(mockDataSourceProvider));
});

final deliveryRepositoryProvider = Provider<DeliveryRepository>((ref) {
  final useFirebase = ref.watch(appConfigProvider).useFirebase;
  if (useFirebase) {
    return FirebaseDeliveryRepository(ref.read(firebaseDataSourceProvider));
  }
  return MockDeliveryRepository(ref.read(mockDataSourceProvider));
});

final warehouseRepositoryProvider = Provider<WarehouseRepository>((ref) {
  final useFirebase = ref.watch(appConfigProvider).useFirebase;
  if (useFirebase) {
    return FirebaseWarehouseRepository(ref.read(firebaseDataSourceProvider));
  }
  return MockWarehouseRepository(ref.read(mockDataSourceProvider));
});

final catalogProvider = FutureProvider<List<Product>>((ref) {
  return ref.read(catalogRepositoryProvider).fetchCatalog();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super(const []);

  bool add(Product product) {
    final existingIndex = state.indexWhere((item) => item.product.id == product.id);
    if (existingIndex == -1) {
      if (product.stock <= 0) {
        return false;
      }
      state = [...state, CartItem(product: product, quantity: 1)];
      return true;
    }

    final currentQuantity = state[existingIndex].quantity;
    if (currentQuantity >= product.stock) {
      return false;
    }

    state = [
      for (final item in state)
        if (item.product.id == product.id)
          CartItem(product: item.product, quantity: item.quantity + 1)
        else
          item,
    ];
    return true;
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      state = state.where((item) => item.product.id != product.id).toList();
      return;
    }

    state = [
      for (final item in state)
        if (item.product.id == product.id)
          CartItem(product: item.product, quantity: quantity)
        else
          item,
    ];
  }

  void clear() {
    state = const [];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

final ordersProvider = FutureProvider<List<Order>>((ref) {
  return ref.read(ordersRepositoryProvider).fetchOrders();
});

final deliveriesProvider = FutureProvider((ref) {
  return ref.read(deliveryRepositoryProvider).fetchDeliveries();
});

final inventoryProvider = FutureProvider((ref) {
  return ref.read(warehouseRepositoryProvider).fetchInventory();
});
