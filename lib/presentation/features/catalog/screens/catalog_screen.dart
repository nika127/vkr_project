import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/app_providers.dart';
import '../../orders/screens/cart_screen.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final catalogAsync = ref.watch(catalogProvider);
    final cartItems = ref.watch(cartProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Поиск товаров',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Badge.count(
                count: cartItems.length,
                isLabelVisible: cartItems.isNotEmpty,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (value) => setState(() => _query = value),
        ),
        const SizedBox(height: 16),
        const Text(
          'Каталог товаров',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        catalogAsync.when(
          data: (products) {
            final filtered = _query.isEmpty
                ? products
                : products
                    .where((product) => product.name
                        .toLowerCase()
                        .contains(_query.toLowerCase()))
                    .toList();
            return Column(
              children: filtered
                  .map(
                    (product) => Card(
                      child: ListTile(
                        leading:
                            CircleAvatar(
                              backgroundImage: product.imageUrl.isEmpty
                                  ? null
                                  : NetworkImage(product.imageUrl),
                              child: product.imageUrl.isEmpty
                                  ? const Icon(Icons.local_florist)
                                  : null,
                            ),
                        title: Text(product.name),
                        subtitle: Text(
                          '${product.description}\n'
                          'Цена: ${product.price.toStringAsFixed(2)} BYN • '
                          'Остаток: ${product.stock} шт.',
                        ),
                        isThreeLine: true,
                        trailing: TextButton(
                          onPressed: () {
                            final added =
                                ref.read(cartProvider.notifier).add(product);
                            if (!added) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Недостаточно товара на складе',
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('В корзину'),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Ошибка загрузки: $error'),
          ),
        ),
      ],
    );
  }
}
