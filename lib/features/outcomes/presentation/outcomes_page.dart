import 'package:flutter/material.dart';

class OutcomesPage extends StatelessWidget {
  const OutcomesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Outcomes')),
      body: const Center(
        child: Text('Burnout risk, recovery time, and clutter impact.'),
      ),
    );
  }
}
