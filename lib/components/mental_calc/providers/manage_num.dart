import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class Sum {
  const Sum({
    required this.num,
    required this.sum,
  });
  final int num;
  final int sum;
}

class NumbersNotifier extends StateNotifier<Sum> {
  NumbersNotifier() : super(const Sum(num: 0, sum: 0));
  List numbers = [];
  int allOfSum = 0;

  void timer() async {
    for (int i = 0; i < 5; i++) {
      int number = Random().nextInt(18);
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          if (i.isEven) {
            state = Sum(num: number, sum: 0);
            allOfSum += number;
          } else {
            state = Sum(num: number, sum: 0);
            allOfSum -= number;
          }
        },
      );
    }
  }

  void result() {
    state = Sum(num: 0, sum: allOfSum);
    allOfSum = 0;
  }
}

final numbersProvider = StateNotifierProvider<NumbersNotifier, Sum>(
  (ref) => NumbersNotifier(),
);
final sumProvider = StateProvider<int>((ref) => 0);
