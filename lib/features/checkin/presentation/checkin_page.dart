import 'package:flutter/material.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});
  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  double sleep = 7.0, mood = 0.75, social = 0.4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quick Check-in')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _SliderTile(
              label: 'Sleep (h)',
              value: sleep,
              min: 0,
              max: 12,
              onChanged: (v) => setState(() => sleep = v),
            ),
            _SliderTile(
              label: 'Mood (%)',
              value: mood * 100,
              min: 0,
              max: 100,
              onChanged: (v) => setState(() => mood = v / 100),
            ),
            _SliderTile(
              label: 'Social Battery (%)',
              value: social * 100,
              min: 0,
              max: 100,
              onChanged: (v) => setState(() => social = v / 100),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {
                // ignore: todo
                // TODO: save, compute metrics, pop
                Navigator.of(context).pop();
              },
              child: const Text('Update Energy Ledger'),
            )
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
  const _SliderTile({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF13171C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$label: ${value.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.titleMedium),
            Slider(value: value, min: min, max: max, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}
