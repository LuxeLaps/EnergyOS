import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/providers_prefs.dart';

class DemoModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.read(sharedPrefsProvider);
    final key = ref.read(demoModeKeyProvider);
    // Default true so the app looks great out-of-the-box
    return prefs.getBool(key) ?? true;
  }

  Future<void> set(bool value) async {
    final prefs = ref.read(sharedPrefsProvider);
    final key = ref.read(demoModeKeyProvider);
    state = value;
    await prefs.setBool(key, value);
  }

  Future<void> toggle() => set(!state);
}

final demoModeProvider =
    NotifierProvider<DemoModeNotifier, bool>(DemoModeNotifier.new);
