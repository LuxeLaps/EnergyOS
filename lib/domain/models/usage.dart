class AppUsageSample {
  final DateTime day; // normalized day
  final String packageName; // e.g., 'com.instagram.android'
  final int foregroundMs; // milliseconds in foreground that day
  const AppUsageSample({
    required this.day,
    required this.packageName,
    required this.foregroundMs,
  });
}

class AppUsageDaily {
  final DateTime day;
  final int totalMs;
  final List<AppTopPackage> topPackages;
  const AppUsageDaily({
    required this.day,
    required this.totalMs,
    required this.topPackages,
  });
}

class AppTopPackage {
  final String packageName;
  final int foregroundMs;
  const AppTopPackage({
    required this.packageName,
    required this.foregroundMs,
  });
}
