import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:async/async.dart';
import 'dart:math';

@immutable
class StoneInformation {
  const StoneInformation({
    required this.id,
    required this.stoneColor,
    required this.visiblity,
  });

  final int id;
  final String stoneColor;
  final bool visiblity;

  // 以下の記述、不要(?)
  // 最後まで実装してエラーが起こらなければそのまま削除
  // StoneInformation copyWith({int? id, bool? stoneColor, bool? visiblity}) {
  //   return StoneInformation(
  //     id: id ?? this.id,
  //     stoneColor: stoneColor ?? this.stoneColor,
  //     visiblity: visiblity ?? this.visiblity,
  //   );
  // }
}

List<String> stoneIro = [
  'black',
  'white',
  // のちに実装
  // 'empty',
];

class StoneNotifier extends StateNotifier<List<StoneInformation>> {
  StoneNotifier() : super([]);
  bool detectTimer = false;

  void initStones(int size) {
    int placementId = 0;
    state = [];
    for (int i = 0; i < size; i++) {
      state = [
        ...state,
        StoneInformation(
          id: placementId,
          stoneColor: stoneIro[Random().nextInt(2)],
          visiblity: false,
        )
      ];
      placementId++;
    }
  }

  void displayAllStones() {
    state = [
      for (final stone in state)
        StoneInformation(
          id: stone.id,
          stoneColor: stone.stoneColor,
          visiblity: true,
        )
    ];
  }

  void hideAllStones() {
    detectTimer = false;
    state = [
      for (final stone in state)
        StoneInformation(
          id: stone.id,
          stoneColor: stone.stoneColor,
          visiblity: false,
        )
    ];
  }

  Future<void> hideAllStonesWithTimer(time) async {
    if (time != 0) {
      detectTimer = true;
      await Future.delayed(
        Duration(seconds: time),
        () {
          if (detectTimer) {
            state = [
              for (final stone in state)
                StoneInformation(
                  id: stone.id,
                  stoneColor: stone.stoneColor,
                  visiblity: false,
                )
            ];
            detectTimer = false;
          }
        },
      );
    }
  }

  void hidestone(int stoneId) {
    state = [
      for (final stone in state)
        if (stone.id == stoneId)
          StoneInformation(
            id: stone.id,
            stoneColor: stone.stoneColor,
            visiblity: true,
          )
        else
          stone
    ];
  }
}

final stoneProvider =
    StateNotifierProvider<StoneNotifier, List<StoneInformation>>(
  (ref) => StoneNotifier(),
);
