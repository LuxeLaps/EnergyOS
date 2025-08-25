import '../models/energy_budget.dart';
import '../models/metrics.dart';

class EnergyBudgetService {
  /// Very simple allocator:
  /// - Start from DailyMetrics.energy as today's "energy pool".
  /// - Subtract item deltas; clamp to 0..100.
  EnergyBudgetPlan compute(DailyMetrics? metrics) {
    final base = (metrics?.energy ?? 65).clamp(0, 100);
    final items = <EnergyBudgetItem>[
      const EnergyBudgetItem(
        id: 'standup',
        title: 'Team standup',
        timeLabel: '09:00',
        energyDeltaPct: -20,
        kind: 'energy',
      ),
      const EnergyBudgetItem(
        id: 'review',
        title: 'Project review',
        timeLabel: '14:00',
        energyDeltaPct: -15,
        kind: 'energy',
      ),
      const EnergyBudgetItem(
        id: 'gym',
        title: 'Gym workout',
        timeLabel: '18:00',
        energyDeltaPct: -10,
        kind: 'energy',
      ),
    ];

    final remaining = items.fold<int>(
        base, (acc, e) => (acc + e.energyDeltaPct).clamp(0, 100));
    return EnergyBudgetPlan(remainingPct: remaining, items: items);
  }
}
