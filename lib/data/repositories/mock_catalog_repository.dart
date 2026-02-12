import '../../domain/entities/product.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/mock_data_source.dart';

class MockCatalogRepository implements CatalogRepository {
  MockCatalogRepository(this._dataSource);

  final MockDataSource _dataSource;

  @override
  Future<List<Product>> fetchCatalog() async {
    return _dataSource.products;
  }

  @override
  Future<List<Product>> searchCatalog(String query) async {
    return _dataSource.products
        .where(
          (product) =>
              product.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
