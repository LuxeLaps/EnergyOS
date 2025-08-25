import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// DI: repo provider that holds latest metrics (created earlier)
import '../../../core/di/providers.dart';
import '../../../domain/models/checkin.dart';

class CheckInPage extends ConsumerStatefulWidget {
  const CheckInPage({super.key});

  @override
  ConsumerState<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends ConsumerState<CheckInPage> {
  double sleep = 7.0;
  double mood = 0.75;
  double social = 0.40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quick Check‑in')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _SliderTile(
              label: 'Sleep (h)',
              value: sleep,
              min: 0,
              max: 12,
              format: (v) => '${v.toStringAsFixed(1)}h',
              onChanged: (v) => setState(() => sleep = v),
            ),
            _SliderTile(
              label: 'Mood (%)',
              value: mood * 100,
              min: 0,
              max: 100,
              format: (v) => '${v.toStringAsFixed(0)}%',
              onChanged: (v) => setState(() => mood = v / 100),
            ),
            _SliderTile(
              label: 'Social Battery (%)',
              value: social * 100,
              min: 0,
              max: 100,
              format: (v) => '${v.toStringAsFixed(0)}%',
              onChanged: (v) => setState(() => social = v / 100),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              icon: const Icon(Icons.energy_savings_leaf_outlined),
              label: const Text('Update Energy Ledger'),
              onPressed: () {
                final c = CheckIn(
                  at: DateTime.now(),
                  sleepHours: sleep,
                  mood: mood,
                  socialBattery: social,
                );
                // Update repository (this recomputes metrics and notifies listeners)
                ref.read(metricsRepoProvider).updateFromCheckIn(c);

                // Go back to the dashboard (works with GoRouter)
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SliderTile extends StatelessWidget {
  final String label;
  final double value, min, max;
  final ValueChanged<double> onChanged;
  final String Function(double)? format;

  const _SliderTile({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.format,
  });

  @override
  Widget build(BuildContext context) {
    final text = format?.call(value) ??
        (max <= 12 ? value.toStringAsFixed(1) : value.toStringAsFixed(0));

    return Card(
      color: const Color(0xFF13171C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$label: $text',
                style: Theme.of(context).textTheme.titleMedium),
            Slider(
              value: value,
              min: min,
              max: max,
              divisions: (max - min).round(),
              label: text,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
