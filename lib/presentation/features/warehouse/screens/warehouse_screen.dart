import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/app_providers.dart';

class WarehouseScreen extends ConsumerWidget {
  const WarehouseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryAsync = ref.watch(inventoryProvider);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Остатки на складе',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        inventoryAsync.when(
          data: (products) => Column(
            children: products
                .map(
                  (product) => Card(
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Text(
                        'Цена: ${product.price.toStringAsFixed(2)} BYN • '
                        'Остаток: ${product.stock} шт.',
                      ),
                      trailing: const Icon(Icons.inventory_2_outlined),
                    ),
                  ),
                )
                .toList(),
          ),
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
