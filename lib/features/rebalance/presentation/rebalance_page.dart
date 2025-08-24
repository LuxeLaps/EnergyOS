import 'package:flutter/material.dart';

class RebalancePage extends StatelessWidget {
  const RebalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Rebalance')),
      body: const Center(
        child: Text('Rebalance suggestions will appear here.'),
      ),
    );
  }
}
