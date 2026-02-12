import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const CircleAvatar(
          radius: 32,
          child: Icon(Icons.person_outline, size: 32),
        ),
        const SizedBox(height: 12),
        const Text(
          'ООО "Арбат Голд Премиум"',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Push-уведомления'),
            trailing: Switch(
              value: true,
              onChanged: (_) {},
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text('Безопасность'),
            subtitle: const Text('JWT, HTTPS, 2FA'),
          ),
        ),
      ],
    );
  }
}
