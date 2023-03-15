import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class NumManager {
  const NumManager({
    required this.num,
    required this.sum,
    required this.numColor,
  });
  final int num;
  final int sum;
  final Color numColor;
}

class NumbersNotifier extends StateNotifier<NumManager> {
  NumbersNotifier()
      : super(const NumManager(num: 10000, sum: 0, numColor: Colors.black));
  List numbers = [];
  int sum = 0;

  void timer(int times) async {
    for (int i = 0; i < times; i++) {
      int number = Random().nextInt(18);
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          if (i.isEven) {
            state = NumManager(num: number, sum: 0, numColor: Colors.red);
            sum += number;
          } else {
            state = NumManager(num: number, sum: 0, numColor: Colors.blue);
            sum -= number;
          }
        },
      );
    }
    await Future.delayed(const Duration(seconds: 1));
    state = const NumManager(num: 10000, sum: 0, numColor: Colors.black);
  }

  void result() {
    state = NumManager(num: 0, sum: sum, numColor: Colors.black);
    sum = 0;
  }

  void retry() {
    state = const NumManager(num: 10000, sum: 0, numColor: Colors.black);
  }
}

final numbersProvider =
    StateNotifierProvider.autoDispose<NumbersNotifier, NumManager>(
  (ref) => NumbersNotifier(),
);
