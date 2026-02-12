import '../entities/product.dart';
import '../repositories/catalog_repository.dart';

class FetchCatalog {
  FetchCatalog(this._repository);

  final CatalogRepository _repository;

  Future<List<Product>> call() {
    return _repository.fetchCatalog();
  }
}
