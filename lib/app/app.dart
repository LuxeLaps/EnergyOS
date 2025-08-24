import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router.dart';

class EnergyApp extends ConsumerWidget {
  const EnergyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'energy_os',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF5BE37D),
          secondary: Color(0xFF00D1FF),
          error: Color(0xFFFF675C),
        ),
        scaffoldBackgroundColor: const Color(0xFF0C0F12),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
