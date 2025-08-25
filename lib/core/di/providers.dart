import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/metrics_repository.dart';
import '../../domain/services/energy_budget_service.dart';

final metricsRepoProvider = ChangeNotifierProvider<MetricsRepository>((ref) {
  return MetricsRepository();
});
final energyBudgetServiceProvider = Provider<EnergyBudgetService>((ref) {
  return EnergyBudgetService();
});
