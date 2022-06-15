import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math';

@immutable
class StoneInformation {
  const StoneInformation({
    required this.id,
    required this.stoneColor,
    required this.visiblity,
  });

  final int id;
  final bool stoneColor;
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

class StoneNotifier extends StateNotifier<List<StoneInformation>> {
  StoneNotifier() : super([]);
  int placementId = 0;

  void initStones(int size) {
    state = [];
    for (int i = 0; i < size; i++) {
      state = [
        ...state,
        StoneInformation(
          id: placementId,
          stoneColor: Random().nextBool(),
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
    state = [
      for (final stone in state)
        StoneInformation(
          id: stone.id,
          stoneColor: stone.stoneColor,
          visiblity: false,
        )
    ];
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
