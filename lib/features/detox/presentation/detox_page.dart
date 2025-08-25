import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../ui/ui_kit.dart';
import '../../../core/di/providers.dart';

class DetoxPage extends ConsumerWidget {
  const DetoxPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    // Optional: if wiring a real Usage repo later, read permission state here.
    // For now we keep the page fully functional in demo mode.
    final demo = ref.watch(demoModeProvider);
    final perm = ref.watch(usagePermissionProvider); // (available, granted)
    final available = demo ? true : (perm.asData?.value.$1 ?? false);
    final granted = demo ? true : (perm.asData?.value.$2 ?? false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Clutter Detox'),
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
          // Header + progress pill
          SectionHeader(
            title: 'Digital Clutter Detox',
            trailing:
                AppChip(label: '78% clutter reduced', color: scheme.secondary),
          ),

          // Permission banner (shown only if feature available and not granted)
          if (available && !granted) ...[
            AppCard(
              color: const Color(0xFF1A1D22),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.security_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Connect usage data',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(
                          'Grant usage access to estimate distractions and show high‑frequency apps. All analysis runs on‑device.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: () async {
                            final repo = ref.read(usageRepoProvider);
                            final ok = await repo.requestPermission();
                            // A simple refresh of providers:
                            ref.invalidate(usagePermissionProvider);
                            if (ok && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Connected usage data')),
                              );
                            }
                          },
                          child: const Text('Connect now'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // KPIs row 1
          const Row(
            children: [
              Expanded(
                child: StatCard(
                  icon: Icons.image_outlined,
                  value: '127',
                  caption: 'Screenshots organized',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  icon: Icons.notifications_outlined,
                  value: '156',
                  caption: 'Notifications bundled',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // KPIs row 2
          const Row(
            children: [
              Expanded(
                child: StatCard(
                  icon: Icons.incomplete_circle_outlined,
                  value: '78%',
                  caption: 'Clutter reduced',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  icon: Icons.spa_outlined,
                  value: '2.3h',
                  caption: 'Time reclaimed',
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const SectionHeader(
            title: 'Smart Actions Ready',
            trailing: AppChip(label: 'OCR processed', color: Colors.green),
          ),

          const SuggestionRow(
            icon: Icons.event_note_outlined,
            title: 'Concert tickets for Friday',
            subtitle: 'Screenshot from Messages',
            trailing: Icon(Icons.chevron_right),
          ),
          const SuggestionRow(
            icon: Icons.account_circle_outlined,
            title: 'Sarah’s new number',
            subtitle: 'Screenshot from WhatsApp',
            trailing: Icon(Icons.chevron_right),
          ),
          const SuggestionRow(
            icon: Icons.receipt_long_outlined,
            title: 'Coffee receipt - \$4.50',
            subtitle: 'Photo from camera',
            trailing: Icon(Icons.chevron_right),
          ),
          const SuggestionRow(
            icon: Icons.picture_as_pdf_outlined,
            title: 'Submit project proposal',
            subtitle: 'PDF from email',
            trailing: Icon(Icons.chevron_right),
          ),

          const SizedBox(height: 16),
          const SectionHeader(
            title: 'Mute Suggestions',
            trailing: AppChip(label: 'Top distractors', color: Colors.amber),
          ),
          const _MuteSuggestionsList(),

          const SizedBox(height: 16),
          DemoBanner(
            textLeft:
                '2‑Minute Demo Complete • Burnout risk ↓40% • Recovery time ↑125% • Privacy 100%',
            ctaLabel: 'Try full version',
            onTap: () {
              // TODO: route to paywall or info
            },
          ),
        ],
      ),
    );
  }
}

class _MuteSuggestionsList extends ConsumerWidget {
  const _MuteSuggestionsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(muteControllerProvider);
    final items = controller.items;
    final selected = controller.selectedIds;

    return AppCard(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'These notifications have low engagement but high frequency:',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (selected.length == items.length) {
                      controller.clear();
                    } else {
                      controller.selectAll();
                    }
                  },
                  child: Text(selected.length == items.length
                      ? 'Clear all'
                      : 'Select all'),
                ),
              ],
            ),
          ),
          for (final it in items)
            _MuteRow(item: it, selected: selected.contains(it.id)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: controller.selectedCount > 0
                      ? controller.muteSelected
                      : null,
                  icon: const Icon(Icons.checklist_rtl),
                  label: Text('Mute selected (${controller.selectedCount})'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: controller.applySmartMuting,
                  child: const Text('Apply smart muting'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MuteRow extends ConsumerWidget {
  final dynamic
      item; // MuteSuggestion but kept dynamic to avoid extra import warnings in some IDEs.
  final bool selected;
  const _MuteRow({required this.item, required this.selected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctl = ref.read(muteControllerProvider);
    return AppCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: const Color(0xFF1A1D22),
      child: InkWell(
        onTap: () => ctl.toggle(item.id),
        child: Row(
          children: [
            Checkbox(
              value: selected,
              onChanged: (_) => ctl.toggle(item.id),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.appName,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(item.reason,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text('${item.perWeek}/week',
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
