class DailyMetrics {
  final DateTime day;
  final int energy; // 0–100
  final int burnoutRisk; // 0–100
  final double recoveryHrs;
  const DailyMetrics({
    required this.day,
    required this.energy,
    required this.burnoutRisk,
    required this.recoveryHrs,
  });
}
