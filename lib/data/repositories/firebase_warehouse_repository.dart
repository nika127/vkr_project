import '../../domain/entities/product.dart';
import '../../domain/repositories/warehouse_repository.dart';
import '../datasources/firebase_datasource.dart';
import '../models/product_model.dart';

class FirebaseWarehouseRepository implements WarehouseRepository {
  FirebaseWarehouseRepository(this._dataSource);

  final FirebaseDataSource _dataSource;

  @override
  Future<List<Product>> fetchInventory() async {
    final data = await _dataSource.fetchCollection('inventory');
    return data
        .asMap()
        .entries
        .map((entry) {
      final id = entry.value['id']?.toString() ?? entry.key.toString();
      return ProductModel.fromMap(entry.value, id);
    })
        .toList();
  }

  @override
  Future<void> updateStock(String productId, int stock) async {
    await _dataSource.setDocument('inventory/$productId', {'stock': stock});
  }
}
