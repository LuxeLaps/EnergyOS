import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/providers.dart';
import '../../../ui/ui_kit.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latest = ref.watch(metricsRepoProvider.select((r) => r.latest));

    final energy = (latest?.energy ?? 65).clamp(0, 100);
    final recoveryHrs = latest?.recoveryHrs ?? 2.5;
    final burnoutRisk = (latest?.burnoutRisk ?? 35).clamp(0, 100);
    final mood =
        latest == null ? 75 : (latest.energy * 0.9).clamp(0, 100).toInt();
    final social = latest == null
        ? 40
        : (100 - (latest.burnoutRisk / 2)).clamp(0, 100).toInt();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Energy Dashboard'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: AppChip(label: 'AI‑powered', icon: Icons.auto_awesome),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed('checkin'),
        icon: const Icon(Icons.edit),
        label: const Text('Quick Check‑in'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Top bars
          ProgressStat(
            title: 'Energy Level',
            valueText: '$energy%',
            progress01: energy / 100,
            icon: Icons.bolt,
          ),
          ProgressStat(
            title: 'Sleep Quality',
            valueText: latest == null
                ? '7.5h'
                : '${(8.0 - (-recoveryHrs)).clamp(0, 12).toStringAsFixed(1)}h',
            progress01:
                ((latest == null ? 7.5 : (8.0 - (-recoveryHrs))).clamp(0, 12) /
                    12.0),
            icon: Icons.bedtime,
            color: Theme.of(context).colorScheme.secondary,
          ),
          ProgressStat(
            title: 'Social Battery',
            valueText: '$social%',
            progress01: social / 100,
            icon: Icons.group_outlined,
          ),
          ProgressStat(
            title: 'Mood',
            valueText: '$mood%',
            progress01: mood / 100,
            icon: Icons.favorite_border,
          ),

          const SizedBox(height: 8),
          // Risk and Recovery panels
          InfoTile(
            title: 'Burnout Risk',
            value: '$burnoutRisk%',
            caption: 'This week • Target ~25%',
            color: Colors.orangeAccent,
          ),
          const SizedBox(height: 12),
          InfoTile(
            title: 'Recovery Time',
            value: '${recoveryHrs.toStringAsFixed(1)}h/day',
            caption: 'Daily average • Smart scheduling added',
            color: Theme.of(context).colorScheme.secondary,
          ),

          const SizedBox(height: 12),
          const SectionHeader(
            title: 'Today’s Energy Budget',
            trailing: AppChip(label: '65% remaining', icon: Icons.trending_up),
          ),
          // Budget items (static demo; wire to allocator later)
          const SuggestionRow(
            icon: Icons.work_outline,
            title: 'Team standup',
            subtitle: '09:00 • −20% energy',
            trailing: Icon(Icons.chevron_right),
          ),
          const SuggestionRow(
            icon: Icons.rate_review_outlined,
            title: 'Project review',
            subtitle: '14:00 • −15% energy',
            trailing: Icon(Icons.chevron_right),
          ),
          const SuggestionRow(
            icon: Icons.fitness_center_outlined,
            title: 'Gym workout',
            subtitle: '18:00 • −10% energy',
            trailing: Icon(Icons.chevron_right),
          ),

          const SizedBox(height: 12),
          const SectionHeader(
            title: 'Smart Rebalance',
            trailing: AppChip(label: 'Energy OS', icon: Icons.memory),
          ),
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ready to optimize?', style: _titleMd(context)),
                const SizedBox(height: 8),
                Text(
                  'AI‑powered schedule optimization for better recovery and focus.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => context.pushNamed('rebalance'),
                  child: const Text('Rebalance My Day'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          DemoBanner(
            textLeft:
                '2‑Minute Demo Complete • Burnout risk ↓40% • Recovery time ↑125% • Privacy 100%',
            ctaLabel: 'Try full version',
            onTap: () => context.pushNamed('settings'),
          ),
        ],
      ),
    );
  }

  TextStyle _titleMd(BuildContext context) {
    final t = Theme.of(context).textTheme.titleMedium;
    if (t != null) return t.copyWith(fontWeight: FontWeight.w600);
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  }
}
