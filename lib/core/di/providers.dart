import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/metrics_repository.dart';
import '../../domain/services/energy_budget_service.dart';
import '../../data/repositories/usage_repository.dart';
import '../../features/detox/application/mute_controller.dart';
import '../../domain/models/mute_suggestion.dart';

//Demo mode on/off
final demoModeProvider = StateProvider<bool>((ref) => true);

final metricsRepoProvider = ChangeNotifierProvider<MetricsRepository>((ref) {
  return MetricsRepository();
});
final energyBudgetServiceProvider = Provider<EnergyBudgetService>((ref) {
  return EnergyBudgetService();
});
// Usage repository – swap to a real implementation later
final usageRepoProvider = Provider<UsageRepository>((ref) {
  return DemoUsageRepository();
});

// Simple usage view-model for Detox (async state)
final weeklyUsageProvider = FutureProvider((ref) async {
  final repo = ref.watch(usageRepoProvider);
  final data = await repo.getWeeklyUsage();
  return data;
});

final usagePermissionProvider = FutureProvider((ref) async {
  final repo = ref.watch(usageRepoProvider);
  final available = await repo.isAvailable();
  final granted = available ? await repo.hasPermission() : false;
  return (available, granted);
});
// Demo mute suggestions sourced from (future) usage repo ranking
final _demoMuteSuggestionsProvider = Provider<List<MuteSuggestion>>((ref) {
  return const [
    MuteSuggestion(
        id: 'com.instagram.android',
        appName: 'Instagram',
        reason: 'Story notifications',
        perWeek: 23),
    MuteSuggestion(
        id: 'com.linkedin.android',
        appName: 'LinkedIn',
        reason: 'Post likes',
        perWeek: 18),
    MuteSuggestion(
        id: 'com.twitter.android',
        appName: 'Twitter',
        reason: 'Trending topics',
        perWeek: 15),
    MuteSuggestion(
        id: 'com.google.android.youtube',
        appName: 'YouTube',
        reason: 'Video recommendations',
        perWeek: 12),
    MuteSuggestion(
        id: 'com.zhiliaoapp.musically',
        appName: 'TikTok',
        reason: 'Live notifications',
        perWeek: 8),
  ];
});

// Controller with ChangeNotifier
final muteControllerProvider = ChangeNotifierProvider<MuteController>((ref) {
  final items = ref.watch(_demoMuteSuggestionsProvider);
  return MuteController(items);
});
