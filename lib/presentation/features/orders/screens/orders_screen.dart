import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/app_providers.dart';
import 'cart_screen.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Текущие заказы',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ordersAsync.when(
          data: (orders) => Column(
            children: orders
                .map(
                  (order) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.receipt_long_outlined),
                      title: Text('Заказ #${order.id}'),
                      subtitle: Text('Статус: ${order.status}'),
                      trailing: Text('${order.total.toStringAsFixed(2)} BYN'),
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
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          },
          icon: const Icon(Icons.add_shopping_cart_outlined),
          label: const Text('Перейти в корзину'),
        ),
      ],
    );
  }
}
