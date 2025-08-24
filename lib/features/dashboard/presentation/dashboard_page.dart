import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Energy Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _MetricCard(title: 'Energy Level', valueText: '65%'),
          SizedBox(height: 12),
          _MetricCard(title: 'Sleep Quality', valueText: '7.5h'),
          SizedBox(height: 12),
          _MetricCard(title: 'Social Battery', valueText: '40%'),
          SizedBox(height: 12),
          _MetricCard(title: 'Mood', valueText: '75%'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/checkin'),
        label: const Text('Quick Check‑in'),
        icon: const Icon(Icons.edit),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String valueText;
  const _MetricCard({required this.title, required this.valueText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF13171C),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          Text(valueText, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
