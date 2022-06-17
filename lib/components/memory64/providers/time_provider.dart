import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class Time {
  const Time({required this.time});
  final int time;
}

class TimeNotifier extends StateNotifier<int> {
  TimeNotifier() : super(0);
}

final timeProvider = StateNotifierProvider<TimeNotifier, int>(
  (ref) => TimeNotifier(),
);
