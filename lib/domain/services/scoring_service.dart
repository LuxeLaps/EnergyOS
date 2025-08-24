import '../models/checkin.dart';
import '../models/metrics.dart';

class ScoringService {
  // Tunables for demo
  static const double optimalSleep = 8.0;
  static const double maxSleep = 12.0;

  DailyMetrics compute(CheckIn c) {
    // Sleep score 0..1
    final sleepDelta = (c.sleepHours - optimalSleep).clamp(-4.0, 4.0);
    final sleepScore =
        1.0 - (sleepDelta.abs() / 4.0); // 1 when 8h, 0 when 4h or 12h

    // Energy base from weighted components
    final energy01 = (0.5 * sleepScore + 0.35 * c.mood + 0.15 * c.socialBattery)
        .clamp(0.0, 1.0);
    final energy = (energy01 * 100).round();

    // Burnout risk increases with sleep debt and low social battery
    final sleepDebt = (optimalSleep - c.sleepHours).clamp(0.0, optimalSleep);
    final risk01 = (0.6 * (sleepDebt / optimalSleep) +
            0.25 * (1 - c.socialBattery) +
            0.15 * (1 - c.mood))
        .clamp(0.0, 1.0);
    final burnout = (risk01 * 100).round();

    // Recovery estimate: if energy low or debt high, recommend more hours
    final needed = (sleepDebt * 0.6 + (1 - c.mood) * 2.0).clamp(0.0, 6.0);

    return DailyMetrics(
      day: DateTime(c.at.year, c.at.month, c.at.day),
      energy: energy,
      burnoutRisk: burnout,
      recoveryHrs: double.parse(needed.toStringAsFixed(1)),
    );
  }
}
