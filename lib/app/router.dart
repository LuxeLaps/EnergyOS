import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/checkin/presentation/checkin_page.dart';
import '../features/rebalance/presentation/rebalance_page.dart';
import '../features/outcomes/presentation/outcomes_page.dart';
import '../features/detox/presentation/detox_page.dart';
import '../features/settings/presentation/settings_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (ctx, st) => const DashboardPage(),
        routes: [
          GoRoute(
            path: '/checkin',
            name: 'checkin',
            builder: (ctx, st) => const CheckInPage(),
          ),
          GoRoute(
            path: '/rebalance',
            name: 'rebalance',
            builder: (ctx, st) => const RebalancePage(),
          ),
          GoRoute(
            path: '/outcomes',
            name: 'outcomes',
            builder: (ctx, st) => const OutcomesPage(),
          ),
          GoRoute(
            path: '/detox',
            name: 'detox',
            builder: (ctx, st) => const DetoxPage(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (ctx, st) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );
});
