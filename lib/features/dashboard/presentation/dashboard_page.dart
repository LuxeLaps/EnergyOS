import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/providers.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(metricsRepoProvider);
    final m = repo.latest;

    final energy = (m?.energy ?? 65).clamp(0, 100);
    // For demo, show sleep as 7.5h if no check-in yet.
    final sleepHours = m == null ? 7.5 : (8.0 - (-m.recoveryHrs)).clamp(0, 12);
    final social = m == null ? 40 : (100 - (m.burnoutRisk / 2)).clamp(0, 100);
    final mood = m == null ? 75 : (m.energy * 0.9).clamp(0, 100);

    return Scaffold(
      appBar: AppBar(title: const Text('Energy Dashboard')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/checkin'),
        icon: const Icon(Icons.edit),
        label: const Text('Quick Check‑in'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _MetricCard(title: 'Energy Level', valueText: '$energy%'),
          const SizedBox(height: 12),
          _MetricCard(
            title: 'Sleep Quality',
            valueText: '${sleepHours.toStringAsFixed(1)}h',
          ),
          const SizedBox(height: 12),
          _MetricCard(title: 'Social Battery', valueText: '${social.round()}%'),
          const SizedBox(height: 12),
          _MetricCard(title: 'Mood', valueText: '${mood.round()}%'),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => context.push('/outcomes'),
            child: const Text('View Outcomes'),
          ),
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
