import 'package:flutter/material.dart';
import '../features/catalog/screens/catalog_screen.dart';
import '../features/orders/screens/orders_screen.dart';
import '../features/deliveries/screens/deliveries_screen.dart';
import '../features/warehouse/screens/warehouse_screen.dart';
import '../features/profile/screens/profile_screen.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    CatalogScreen(),
    OrdersScreen(),
    DeliveriesScreen(),
    WarehouseScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arbat Gold Premium',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB57E2E)),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Арбат Голд Премиум'),
        ),
        body: _screens[_currentIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.storefront_outlined),
              label: 'Каталог',
            ),
            NavigationDestination(
              icon: Icon(Icons.list_alt_outlined),
              label: 'Заказы',
            ),
            NavigationDestination(
              icon: Icon(Icons.local_shipping_outlined),
              label: 'Доставка',
            ),
            NavigationDestination(
              icon: Icon(Icons.warehouse_outlined),
              label: 'Склад',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}
