class CheckIn {
  final DateTime at;
  final double sleepHours; // 0–12
  final double mood; // 0–1
  final double socialBattery; // 0–1
  const CheckIn({
    required this.at,
    required this.sleepHours,
    required this.mood,
    required this.socialBattery,
  });
}
