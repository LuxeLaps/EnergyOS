import 'dart:math';
import '../../domain/models/usage.dart';

abstract class UsageRepository {
  Future<bool> isAvailable(); // platform available
  Future<bool> hasPermission(); // user granted access
  Future<bool> requestPermission(); // trigger system page / prompt
  Future<List<AppUsageDaily>> getWeeklyUsage({DateTime? anchor}); // last 7 days
}

// Demo in-memory implementation
class DemoUsageRepository implements UsageRepository {
  final Random _rng = Random(42);

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<bool> hasPermission() async => false; // default to not granted

  @override
  Future<bool> requestPermission() async {
    // In demo, pretend user granted it
    return true;
  }

  @override
  Future<List<AppUsageDaily>> getWeeklyUsage({DateTime? anchor}) async {
    final now = anchor ?? DateTime.now();
    final days = List.generate(7, (i) {
      final d =
          DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
      // Fake totals 2–4 hours/day
      final total = (2 + _rng.nextInt(3)) * 60 * 60 * 1000;
      final pkgs = <AppTopPackage>[
        AppTopPackage(
            packageName: 'com.instagram.android',
            foregroundMs: (total * 0.25).toInt()),
        AppTopPackage(
            packageName: 'com.linkedin.android',
            foregroundMs: (total * 0.20).toInt()),
        AppTopPackage(
            packageName: 'com.twitter.android',
            foregroundMs: (total * 0.18).toInt()),
        AppTopPackage(
            packageName: 'com.google.android.youtube',
            foregroundMs: (total * 0.15).toInt()),
        AppTopPackage(
            packageName: 'com.zhiliaoapp.musically',
            foregroundMs: (total * 0.10).toInt()),
      ];
      return AppUsageDaily(day: d, totalMs: total, topPackages: pkgs);
    });
    return days;
  }
}
