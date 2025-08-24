import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/metrics_repository.dart';

final metricsRepoProvider = ChangeNotifierProvider<MetricsRepository>((ref) {
  return MetricsRepository();
});
