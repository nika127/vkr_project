import '../../domain/entities/product.dart';
import '../../domain/repositories/warehouse_repository.dart';
import '../datasources/mock_data_source.dart';

class MockWarehouseRepository implements WarehouseRepository {
  MockWarehouseRepository(this._dataSource);

  final MockDataSource _dataSource;

  @override
  Future<List<Product>> fetchInventory() async {
    return _dataSource.products;
  }

  @override
  Future<void> updateStock(String productId, int stock) async {
    _dataSource.products = _dataSource.products
        .map(
          (product) => product.id == productId
              ? Product(
                  id: product.id,
                  name: product.name,
                  description: product.description,
                  price: product.price,
                  stock: stock,
                  imageUrl: product.imageUrl,
                )
              : product,
        )
        .toList();
  }
}
