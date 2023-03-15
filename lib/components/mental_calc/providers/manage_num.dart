import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class NumManager {
  const NumManager({
    required this.num,
    required this.sum,
  });
  final int num;
  final int sum;
}

class NumbersNotifier extends StateNotifier<NumManager> {
  NumbersNotifier() : super(const NumManager(num: 0, sum: 0));
  List numbers = [];
  int sum = 0;

  void timer() async {
    for (int i = 0; i < 5; i++) {
      int number = Random().nextInt(18);
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          if (i.isEven) {
            state = NumManager(num: number, sum: 0);
            sum += number;
          } else {
            state = NumManager(num: number, sum: 0);
            sum -= number;
          }
        },
      );
    }
  }

  void result() {
    state = NumManager(num: 0, sum: sum);
    sum = 0;
  }
}

final numbersProvider =
    StateNotifierProvider.autoDispose<NumbersNotifier, NumManager>(
  (ref) => NumbersNotifier(),
);
final sumProvider = StateProvider<int>((ref) => 0);
