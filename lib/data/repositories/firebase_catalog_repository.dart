import '../../domain/entities/product.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/firebase_datasource.dart';
import '../models/product_model.dart';

class FirebaseCatalogRepository implements CatalogRepository {
  FirebaseCatalogRepository(this._dataSource);

  final FirebaseDataSource _dataSource;

  @override
  Future<List<Product>> fetchCatalog() async {
    final data = await _dataSource.fetchCollection('products');
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
  Future<List<Product>> searchCatalog(String query) async {
    final allProducts = await fetchCatalog();
    return allProducts
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
