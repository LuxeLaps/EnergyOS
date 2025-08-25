import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/providers.dart';

class OutcomesPage extends ConsumerWidget {
  const OutcomesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = ref.watch(metricsRepoProvider).latest;

    final risk = m?.burnoutRisk ?? 35;
    final recovery = m?.recoveryHrs ?? 2.5;

    return Scaffold(
      appBar: AppBar(title: const Text('Outcomes')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _OutcomeTile(
            title: 'Weekly Burnout Risk',
            value: '$risk%',
            caption: 'After optimization target ~25%',
          ),
          const SizedBox(height: 12),
          _OutcomeTile(
            title: 'Recovery Time Gained',
            value: '${recovery.toStringAsFixed(1)}h/day',
            caption: 'More rest suggested for balance',
          ),
        ],
      ),
    );
  }
}

class _OutcomeTile extends StatelessWidget {
  final String title;
  final String value;
  final String caption;
  const _OutcomeTile({
    super.key,
    required this.title,
    required this.value,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF13171C),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(caption, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
