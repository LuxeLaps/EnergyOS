import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/providers.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metrics = ref.watch(metricsRepoProvider).latest;
    final energy = metrics?.energy ?? 65;
    final sleep = metrics?.recoveryHrs != null
        ? (8 - metrics!.recoveryHrs).clamp(0, 12)
        : 7.5; // temp
    return Scaffold(
      appBar: AppBar(title: const Text('Energy Dashboard')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/checkin'),
        label: const Text('Quick Check‑in'),
        icon: const Icon(Icons.edit),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _MetricCard(title: 'Energy Level', valueText: '$energy%'),
          const SizedBox(height: 12),
          _MetricCard(
              title: 'Sleep Quality',
              valueText: '${sleep is num ? sleep.toStringAsFixed(1) : sleep}h'),
          const SizedBox(height: 12),
          const _MetricCard(title: 'Social Battery', valueText: '40%'),
          const SizedBox(height: 12),
          const _MetricCard(title: 'Mood', valueText: '75%'),
        ],
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
