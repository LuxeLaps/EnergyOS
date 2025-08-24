import 'package:flutter/material.dart';

class DetoxPage extends StatelessWidget {
  const DetoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Digital Clutter Detox')),
      body: const Center(
        child: Text('OCR inbox and smart actions will live here.'),
      ),
    );
  }
}
