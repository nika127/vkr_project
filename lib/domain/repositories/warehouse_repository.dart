import '../entities/product.dart';

abstract class WarehouseRepository {
  Future<List<Product>> fetchInventory();
  Future<void> updateStock(String productId, int stock);
}
