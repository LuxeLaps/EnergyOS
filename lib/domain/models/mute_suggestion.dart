class MuteSuggestion {
  final String id; // stable key (e.g., package name)
  final String appName; // Instagram
  final String reason; // Story notifications
  final int perWeek; // 23/week

  const MuteSuggestion({
    required this.id,
    required this.appName,
    required this.reason,
    required this.perWeek,
  });
}
