import 'package:flutter/material.dart';
import '../../../ui/ui_kit.dart';

class DetoxPage extends StatelessWidget {
  const DetoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

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
          // Title + progress chip
          SectionHeader(
            title: 'Digital Clutter Detox',
            trailing:
                AppChip(label: '78% clutter reduced', color: scheme.secondary),
          ),
          const SizedBox(height: 8),

          // KPIs row
          const Row(
            children: [
              Expanded(
                  child: StatCard(
                      icon: Icons.image_outlined,
                      value: '127',
                      caption: 'Screenshots organized')),
              SizedBox(width: 12),
              Expanded(
                  child: StatCard(
                      icon: Icons.notifications_outlined,
                      value: '156',
                      caption: 'Notifications bundled')),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                  child: StatCard(
                      icon: Icons.incomplete_circle_outlined,
                      value: '78%',
                      caption: 'Clutter reduced')),
              SizedBox(width: 12),
              Expanded(
                  child: StatCard(
                      icon: Icons.spa_outlined,
                      value: '2.3h',
                      caption: 'Time reclaimed')),
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
          AppCard(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                  child: Text(
                    'These notifications have low engagement but high frequency:',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                _muteRow(context, 'Instagram', 'Story notifications', '23/week',
                    scheme),
                _muteRow(context, 'LinkedIn', 'Post likes', '18/week', scheme),
                _muteRow(
                    context, 'Twitter', 'Trending topics', '15/week', scheme),
                _muteRow(context, 'YouTube', 'Video recommendations', '12/week',
                    scheme),
                _muteRow(
                    context, 'TikTok', 'Live notifications', '8/week', scheme),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {}, // TODO: selection flow
                        icon: const Icon(Icons.checklist_rtl),
                        label: const Text('Mute selected (10)'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {}, // TODO: smart muting flow
                        child: const Text('Apply smart muting'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          DemoBanner(
            textLeft:
                '2‑Minute Demo Complete • Burnout risk ↓40% • Recovery time ↑125% • Privacy 100%',
            ctaLabel: 'Try full version',
            onTap: () {}, // TODO: route to paywall or info
          ),
        ],
      ),
    );
  }

  Widget _muteRow(
    BuildContext context,
    String app,
    String reason,
    String perWeek,
    ColorScheme scheme,
  ) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: const Color(0xFF1A1D22),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: scheme.onSurface.withOpacity(0.7)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(app, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(reason, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(perWeek, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
