import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            title: Text('Demo mode'),
            subtitle: Text('Populate the app with sample data'),
          ),
          ListTile(
            title: Text('Privacy'),
            subtitle: Text('All data processed on-device'),
          ),
        ],
      ),
    );
  }
}
