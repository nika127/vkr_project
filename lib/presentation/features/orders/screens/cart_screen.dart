import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/app_providers.dart';
import '../../../../domain/entities/order.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = cartItems.fold<double>(0, (sum, item) => sum + item.total);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.product.name),
                      subtitle: Text('Кол-во: ${item.quantity}'),
                      trailing: SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(cartProvider.notifier)
                                    .updateQuantity(
                                      item.product,
                                      item.quantity - 1,
                                    );
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            IconButton(
                              onPressed: () {
                                if (item.quantity >= item.product.stock) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Недостаточно товара на складе',
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                ref
                                    .read(cartProvider.notifier)
                                    .updateQuantity(
                                      item.product,
                                      item.quantity + 1,
                                    );
                              },
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Итого',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text('${total.toStringAsFixed(2)} BYN'),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cartItems.isEmpty
                    ? null
                    : () async {
                        final order = Order(
                          id: 'AGP-${DateTime.now().millisecondsSinceEpoch}',
                          clientName: 'Магазин "Арбат Голд"',
                          address: 'Минск, ул. Ленина, 1',
                          status: 'в обработке',
                          total: total,
                        );
                        await ref
                            .read(ordersRepositoryProvider)
                            .submitOrder(order);
                        ref.read(cartProvider.notifier).clear();
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Заказ создан и отправлен'),
                            ),
                          );
                        }
                      },
                child: const Text('Оформить заказ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
