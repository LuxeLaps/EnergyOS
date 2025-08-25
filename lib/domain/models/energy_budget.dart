class EnergyBudgetItem {
  final String id;
  final String title;
  final String timeLabel; // e.g., '09:00'
  final int energyDeltaPct; // negative means consumption
  final String kind; // 'energy' / 'focus' etc.
  const EnergyBudgetItem({
    required this.id,
    required this.title,
    required this.timeLabel,
    required this.energyDeltaPct,
    required this.kind,
  });
}

class EnergyBudgetPlan {
  final int remainingPct; // 0..100
  final List<EnergyBudgetItem> items;
  const EnergyBudgetPlan({required this.remainingPct, required this.items});
}
