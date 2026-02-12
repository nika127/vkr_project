import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/app_providers.dart';

class DeliveriesScreen extends ConsumerWidget {
  const DeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveriesAsync = ref.watch(deliveriesProvider);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Маршруты доставки',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        deliveriesAsync.when(
          data: (deliveries) => Column(
            children: deliveries
                .map(
                  (delivery) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.map_outlined),
                      title: Text('Маршрут #${delivery.id}'),
                      subtitle: Text(
                        '${delivery.status} • ${delivery.routeDistanceKm.toStringAsFixed(1)} км',
                      ),
                      trailing: TextButton(
                        onPressed: () {},
                        child: const Text('Открыть'),
                      ),
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
        const SizedBox(height: 16),
        const Text(
          'Обновление геолокации включено',
          style: TextStyle(color: Colors.green),
        ),
      ],
    );
  }
}
