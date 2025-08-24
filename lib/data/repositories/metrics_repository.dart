import 'package:flutter/foundation.dart';
import '../../domain/models/checkin.dart';
import '../../domain/models/metrics.dart';
import '../../domain/services/scoring_service.dart';

class MetricsRepository extends ChangeNotifier {
  final _scoring = ScoringService();

  DailyMetrics? _latest;
  DailyMetrics? get latest => _latest;

  void updateFromCheckIn(CheckIn c) {
    _latest = _scoring.compute(c);
    notifyListeners();
  }
}
