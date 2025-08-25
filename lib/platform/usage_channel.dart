import 'package:flutter/services.dart';

class UsageChannel {
  static const _channel = MethodChannel('energy_os/usage');

  Future<bool> isAvailable() async =>
      await _channel.invokeMethod<bool>('isAvailable') ?? false;

  Future<bool> hasPermission() async =>
      await _channel.invokeMethod<bool>('hasPermission') ?? false;

  Future<bool> requestPermission() async =>
      await _channel.invokeMethod<bool>('requestPermission') ?? false;

  Future<List<Map<String, dynamic>>> getWeeklyUsage() async {
    final result =
        await _channel.invokeMethod<List<dynamic>>('getWeeklyUsage') ??
            const [];
    return result.cast<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
  }
}
