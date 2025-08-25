import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/providers.dart';
import '../../../ui/ui_kit.dart';

class OutcomesPage extends ConsumerWidget {
  const OutcomesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latest = ref.watch(metricsRepoProvider.select((r) => r.latest));
    final recovery = latest?.recoveryHrs ?? 2.5;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Outcomes'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: AppChip(label: 'AI‑powered', icon: Icons.auto_awesome),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(
            title: 'Weekly Burnout Risk',
            trailing: AppChip(label: 'risk', color: Colors.orange),
          ),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _beforeAfterRow(context, 'Before optimization', '65% risk'),
                const SizedBox(height: 8),
                _beforeAfterRow(context, 'After optimization', '25% risk',
                    highlight: true),
                const SizedBox(height: 12),
                const AppCard(
                  color: Color(0xFF0E1410),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Icon(Icons.trending_down, color: Color(0xFF5BE37D)),
                      SizedBox(width: 8),
                      Expanded(
                          child: Text('40% improvement in burnout prevention')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader(
            title: 'Recovery Time Gained',
            trailing: AppChip(label: '+2.5h/day', color: Colors.lightBlue),
          ),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _kvRow(context, 'Previous week', '2.0h/day'),
                const SizedBox(height: 8),
                _kvRow(
                    context, 'This week', '${recovery.toStringAsFixed(1)}h/day',
                    strong: true),
                const SizedBox(height: 12),
                const AppCard(
                  color: Color(0xFF0E111A),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Icon(Icons.bolt, color: Colors.lightBlueAccent),
                      SizedBox(width: 8),
                      Expanded(child: Text('+2.5 hours daily for self‑care')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader(
            title: 'Digital Clutter Impact',
            trailing: AppChip(label: '−85% distractions'),
          ),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _kvRow(context, 'Notifications before', '156/day',
                    color: Colors.redAccent),
                const SizedBox(height: 8),
                _kvRow(context, 'Notifications after', '23/day',
                    color: Colors.greenAccent),
                const SizedBox(height: 12),
                const AppCard(
                  color: Color(0xFF12100F),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Icon(Icons.lock_outline, color: Color(0xFFE0B000)),
                      SizedBox(width: 8),
                      Expanded(child: Text('85% reduction in distractions')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader(
              title: 'Privacy Score', trailing: AppChip(label: '100%')),
          const AppCard(
            child: Column(
              children: [
                _kvRowStatic(label: 'Data on‑device', value: '100%'),
                SizedBox(height: 8),
                _kvRowStatic(label: 'Cloud dependencies', value: '0'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const DemoBanner(
            textLeft:
                '2‑Minute Demo Complete • Burnout risk ↓40% • Recovery time ↑125% • Privacy 100%',
            ctaLabel: 'Try full version',
          ),
        ],
      ),
    );
  }
}

Widget _beforeAfterRow(BuildContext context, String label, String value,
    {bool highlight = false}) {
  final style = Theme.of(context).textTheme.titleMedium;
  final color = highlight ? Colors.greenAccent : null;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: style),
      Text(value, style: style?.copyWith(color: color)),
    ],
  );
}

Widget _kvRow(BuildContext context, String label, String value,
    {bool strong = false, Color? color}) {
  final style = strong
      ? Theme.of(context).textTheme.titleLarge
      : Theme.of(context).textTheme.titleMedium;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: Theme.of(context).textTheme.titleMedium),
      Text(value, style: style?.copyWith(color: color)),
    ],
  );
}

class _kvRowStatic extends StatelessWidget {
  final String label;
  final String value;
  const _kvRowStatic({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
