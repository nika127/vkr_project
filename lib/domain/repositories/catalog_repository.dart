import '../entities/product.dart';

abstract class CatalogRepository {
  Future<List<Product>> fetchCatalog();
  Future<List<Product>> searchCatalog(String query);
}
